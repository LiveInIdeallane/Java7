package controller.systemAdmin;

import entity.BackdownS.Backdown;
import entity.BedS.Bed;
import entity.CustomerS.Customer;
import entity.OutwardS.Outward;
import service.BackdownS.BackdownService;
import service.BackdownS.BackdownServiceImpl;
import service.BedDetailsS.BedDetailsService;
import service.BedDetailsS.BedDetailsServiceImpl;
import service.BedS.BedService;
import service.BedS.BedServiceImpl;
import service.CustomernurseitemS.CustomernurseitemService;
import service.CustomernurseitemS.CustomernurseitemServiceImpl;
import service.CustomerS.CustomerService;
import service.CustomerS.CustomerServiceImpl;
import service.OutwardS.OutwardService;
import service.OutwardS.OutwardServiceImpl;
import service.RoomS.RoomService;
import service.RoomS.RoomServiceImpl;
import utils.Tools;
import controller.LoginController;

import java.text.ParseException;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Scanner;

/**
 * 客户管理 Controller（控制台）。
 * 菜单：1入住登记 2退住登记 3外出登记。
 *
 * 分层约定：controller 只做界面交互、收集并校验参数、调用 service、展示结果；
 * 业务规则（释放床位、改床位状态、逻辑删除等）全部放在 service 层，controller 不写 SQL。
 */
public class CustomerController {

    private static final Scanner scanner = new Scanner(System.in);

    private static final CustomerService customerService = new CustomerServiceImpl();
    private static final BackdownService backdownService = new BackdownServiceImpl();
    private static final OutwardService outwardService = new OutwardServiceImpl();
    private static final RoomService roomService = new RoomServiceImpl();
    private static final BedService bedService = new BedServiceImpl();
    private static final BedDetailsService bedDetailsService = new BedDetailsServiceImpl();
    private static final CustomernurseitemService nurseItemService = new CustomernurseitemServiceImpl();

    private static final String BUILDING_NO = "606";   // 楼栋信息不维护，固定606
    private static final int RETREAT_NORMAL = 1;       // 正常退住
    private static final int RETREAT_DEATH = 2;        // 死亡退住
    private static final int RETREAT_KEEP_BED = 3;     // 保留床位
    private static final int AUDIT_PASS = 1;           // 审核通过
    private static final int AUDIT_REJECT = 2;         // 审核

    // 不通过

    // ==================== 主菜单 ====================

    public static void menu() {
        while (true) {
            printTitle("客户管理");
            System.out.println("1、入住登记");
            System.out.println("2、退住登记");
            System.out.println("3、外出登记");
            System.out.println("0、返回上层菜单");
            String select = input("请输入序号：");
            switch (select) {
                case "1":
                    checkinMenu();
                    break;
                case "2":
                    backdownMenu();
                    break;
                case "3":
                    outwardMenu();
                    break;
                case "0":
                    return;
                default:
                    System.out.println("输入有误，请重新输入！");
            }
        }
    }

    // ==================== 一、入住登记 ====================

    private static void checkinMenu() {
        while (true) {
            printTitle("入住登记");
            System.out.println("1、查询客户信息列表");
            System.out.println("2、登记客户入住信息");
            System.out.println("3、修改客户信息");
            System.out.println("4、删除客户信息");
            System.out.println("0、返回上层菜单");
            String select = input("请输入序号：");
            switch (select) {
                case "1":
                    listCustomers();
                    break;
                case "2":
                    registerCheckin();
                    break;
                case "3":
                    updateCustomer();
                    break;
                case "4":
                    deleteCustomer();
                    break;
                case "0":
                    return;
                default:
                    System.out.println("输入有误，请重新输入！");
            }
        }
    }

    /** 查询客户列表：默认自理老人，支持姓名模糊 + 老人类型组合查询 */
    private static void listCustomers() {
        String name = input("客户姓名（模糊，回车不过滤）：");
        String type = input("老人类型（0自理 1护理，回车默认自理）：");
        boolean onlyNurse = "1".equals(type);

        List<Customer> all = customerService.findAllCustomers();
        List<Customer> result = new ArrayList<>();
        for (Customer c : all) {
            if (c.getIs_deleted() != null && c.getIs_deleted() != 0) {
                continue;
            }
            if (!name.isEmpty() && (c.getCustomer_name() == null
                    || !c.getCustomer_name().contains(name))) {
                continue;
            }
            if (isNurseCustomer(c) != onlyNurse) {
                continue;
            }
            result.add(c);
        }

        if (result.isEmpty()) {
            System.out.println("没有符合条件的客户！");
            return;
        }
        System.out.printf("%-5s%-10s%-6s%-6s%-22s%-8s%-8s%-12s%-12s%-8s%n",
                "ID", "姓名", "年龄", "性别", "身份证号", "楼栋", "房间", "床位", "合同到期", "类型");
        for (Customer c : result) {
            System.out.printf("%-5d%-10s%-6s%-6s%-22s%-8s%-8s%-12s%-12s%-8s%n",
                    c.getId(),
                    c.getCustomer_name(),
                    c.getCustomer_age(),
                    sexText(c.getCustomer_sex()),
                    c.getIdcard(),
                    c.getBuilding_no(),
                    c.getRoom_no(),
                    c.getBed_id(),
                    fmt(c.getExpiration_date()),
                    isNurseCustomer(c) ? "护理老人" : "自理老人");
        }
    }

    /** 登记入住：年龄按出生日期自动计算；合同到期不能小于入住时间；房间/床位联动选择 */
    private static void registerCheckin() {
        String name = input("客户姓名：");
        if (name.isEmpty()) {
            System.out.println("客户姓名不能为空！");
            return;
        }

        Date birthday = parseDate(input("出生日期(yyyy-MM-dd)："));
        if (birthday == null) {
            System.out.println("出生日期格式错误！");
            return;
        }
        int age = calcAge(birthday);

        String sex = input("性别(0男 1女)：");
        if (!"0".equals(sex) && !"1".equals(sex)) {
            System.out.println("性别输入有误！");
            return;
        }

        String idcard = input("身份证号：");
        if (idcard.isEmpty()) {
            System.out.println("身份证号不能为空！");
            return;
        }
        if (!customerService.search("", "", idcard, "").isEmpty()) {
            System.out.println("该身份证号已登记过！");
            return;
        }

        String bloodType = input("血型：");
        String family = input("家属：");
        String tel = input("联系电话：");
        if (tel.isEmpty()) {
            System.out.println("联系电话不能为空！");
            return;
        }

        //楼栋固定606
        //房间号：按楼层分组展示，下拉选择
        Map<String, List<String>> rooms = roomService.getRoomsGroupByFloor();
        if (rooms.isEmpty()) {
            System.out.println("暂无房间数据，无法登记入住！");
            return;
        }
        System.out.println("可选房间（按楼层分组）：");
        for (Map.Entry<String, List<String>> entry : rooms.entrySet()) {
            System.out.println("  " + entry.getKey() + " -> " + entry.getValue());
        }
        String roomNo = input("请选择房间号：");
        if (!containsRoom(rooms, roomNo)) {
            System.out.println("所选房间号不存在！");
            return;
        }

        //床位号：根据房间号联动获取空闲床位
        List<Bed> freeBeds = bedService.getFreeBedsByRoomNo(Integer.parseInt(roomNo));
        if (freeBeds.isEmpty()) {
            System.out.println("该房间没有空闲床位！");
            return;
        }
        System.out.println("该房间空闲床位：" + freeBeds);
        int bedId = inputInt("请选择床位ID：");
        if (!freeBeds.contains(bedId)) {
            System.out.println("所选床位不是该房间的空闲床位！");
            return;
        }

        Date checkin = new Date();
        String s = input("入住时间(yyyy-MM-dd，回车默认今天)：");
        if (!s.isEmpty()) {
            checkin = parseDate(s);
            if (checkin == null) {
                System.out.println("入住时间格式错误！");
                return;
            }
        }

        Date expiration = parseDate(input("合同到期时间(yyyy-MM-dd)："));
        if (expiration == null) {
            System.out.println("合同到期时间格式错误！");
            return;
        }
        if (expiration.before(checkin)) {
            System.out.println("合同到期时间不能小于入住时间！");
            return;
        }

        String state = input("身心状况(可空)：");
        String attention = input("注意事项(可空)：");
        Integer levelId = inputIntOrNull("护理等级ID(可空)：");
        Integer userId = inputIntOrNull("健康管家ID(可空)：");

        Customer c = new Customer();
        c.setIs_deleted(0);
        c.setCustomer_name(name);
        c.setCustomer_age(age);
        c.setCustomer_sex(Integer.valueOf(sex));
        c.setIdcard(idcard);
        c.setBuilding_no(BUILDING_NO);
        c.setRoom_no(roomNo);
        c.setBed_id(bedId);
        c.setCheckin_date(checkin);
        c.setExpiration_date(expiration);
        c.setContact_tel(tel);
        c.setBlood_type(bloodType);
        c.setFamily_number(family);
        c.setBirthday(birthday);
        c.setPsychosomatic_state(state);
        c.setAttention(attention);
        c.setLevel_id(levelId);
        c.setUser_id(userId);

        System.out.println(customerService.createCustomer(c) ? "入住登记成功！" : "入住登记失败！");
    }

    /** 修改客户信息：合同到期时间改变时，同步更新当前生效床位信息的退住时间 */
    private static void updateCustomer() {
        int id = inputInt("请输入要修改的客户ID：");
        Customer old = customerService.findCustomerById(id);
        if (old == null) {
            System.out.println("客户不存在！");
            return;
        }

        try {
            Customer c = new Customer();
            c.setId(old.getId());
            c.setIs_deleted(old.getIs_deleted());
            c.setCustomer_name(keep("客户姓名(" + old.getCustomer_name() + ")：", old.getCustomer_name()));
            String age = input("年龄(" + old.getCustomer_age() + ")：");
            c.setCustomer_age(age.isEmpty() ? old.getCustomer_age() : Integer.valueOf(age));
            String sex = input("性别(0男 1女)(" + old.getCustomer_sex() + ")：");
            c.setCustomer_sex(sex.isEmpty() ? old.getCustomer_sex() : Integer.valueOf(sex));
            c.setIdcard(keep("身份证号(" + old.getIdcard() + ")：", old.getIdcard()));
            c.setRoom_no(keep("房间号(" + old.getRoom_no() + ")：", old.getRoom_no()));
            c.setContact_tel(keep("联系电话(" + old.getContact_tel() + ")：", old.getContact_tel()));
            c.setFamily_number(keep("家属(" + old.getFamily_number() + ")：", old.getFamily_number()));
            c.setBlood_type(keep("血型(" + old.getBlood_type() + ")：", old.getBlood_type()));
            c.setPsychosomatic_state(keep("身心状况：", old.getPsychosomatic_state()));
            c.setAttention(keep("注意事项：", old.getAttention()));

            Date expiration = keepDate("合同到期时间(" + fmt(old.getExpiration_date()) + ")：",
                    old.getExpiration_date());
            boolean expirationChanged = expiration != null
                    && !expiration.equals(old.getExpiration_date());
            if (expirationChanged && expiration.before(old.getCheckin_date())) {
                System.out.println("合同到期时间不能小于入住时间！");
                return;
            }
            c.setCheckin_date(old.getCheckin_date());
            c.setExpiration_date(expiration);
            c.setBuilding_no(old.getBuilding_no());
            c.setBed_id(old.getBed_id());
            c.setBirthday(old.getBirthday());
            c.setHeight(old.getHeight());
            c.setWeight(old.getWeight());
            c.setFilepath(old.getFilepath());
            c.setUser_id(old.getUser_id());
            c.setLevel_id(old.getLevel_id());

            if (!customerService.updateCustomer(c)) {
                System.out.println("修改失败！");
                return;
            }
            //合同到期时间变化 -> 更新当前生效床位信息的退住时间
            if (expirationChanged) {
                bedDetailsService.updateEndDate(id, expiration);
            }
            System.out.println("修改成功！");
        } catch (NumberFormatException | ParseException e) {
            System.out.println("输入格式错误：" + e.getMessage());
        }
    }

    /** 删除客户：逻辑删除客户 + 释放床位 + 逻辑删除当前生效的床位使用记录 */
    private static void deleteCustomer() {
        int id = inputInt("请输入要删除的客户ID：");
        Customer c = customerService.findCustomerById(id);
        if (c == null) {
            System.out.println("客户不存在！");
            return;
        }
        if (!"y".equalsIgnoreCase(input("确认删除客户【" + c.getCustomer_name() + "】？(y/n)：").trim())) {
            System.out.println("已取消删除！");
            return;
        }
        if (!customerService.deleteCustomer(c)) {
            System.out.println("删除失败！");
            return;
        }
        //床位状态改为空闲
        if (c.getBed_id() != null) {
            bedService.freeBed(c.getBed_id());
        }
        //床位使用详情逻辑删除（只隐藏当前生效的一条记录）
        bedDetailsService.logicDeleteActiveByCustomer(id);
        System.out.println("删除成功！");
    }

    // ==================== 二、退住登记 ====================

    private static void backdownMenu() {
        while (true) {
            printTitle("退住登记");
            System.out.println("1、浏览退住登记信息");
            System.out.println("2、按客户姓名查询");
            System.out.println("3、审核退住申请");
            System.out.println("0、返回上层菜单");
            String select = input("请输入序号：");
            switch (select) {
                case "1":
                    printBackdowns(backdownService.findAllBackdowns());
                    break;
                case "2":
                    String name = input("客户姓名（模糊）：");
                    List<Backdown> filtered = new ArrayList<>();
                    for (Backdown b : backdownService.findAllBackdowns()) {
                        String cName = customerNameOf(b.getCustomer_id());
                        if (cName != null && cName.contains(name)) {
                            filtered.add(b);
                        }
                    }
                    printBackdowns(filtered);
                    break;
                case "3":
                    auditBackdown();
                    break;
                case "0":
                    return;
                default:
                    System.out.println("输入有误，请重新输入！");
            }
        }
    }

    private static void printBackdowns(List<Backdown> list) {
        if (list == null || list.isEmpty()) {
            System.out.println("暂无退住登记信息！");
            return;
        }
        System.out.printf("%-5s%-10s%-12s%-10s%-16s%-8s%-10s%-12s%n",
                "ID", "客户ID", "客户姓名", "退住时间", "退住类型", "状态", "审批人", "审批时间");
        for (Backdown b : list) {
            System.out.printf("%-5d%-10d%-12s%-10s%-16s%-8s%-10s%-12s%n",
                    b.getId(),
                    b.getCustomer_id(),
                    customerNameOf(b.getCustomer_id()),
                    fmt(b.getRetreattime()),
                    retreatTypeText(b.getRetreattype()),
                    auditText(b.getAuditstatus()),
                    b.getAuditperson(),
                    fmt(b.getAudittime()));
        }
    }

    /** 审核退住：正常退住/死亡退住通过时，把客户正在使用的床位改为可用 */
    private static void auditBackdown() {
        int id = inputInt("请输入要审核的退住登记ID：");
        Backdown b = backdownService.findBackdownById(id);
        if (b == null) {
            System.out.println("退住登记不存在！");
            return;
        }
        if (b.getAuditstatus() != null && b.getAuditstatus() != 0) {
            System.out.println("该申请已审核，不能重复审核！");
            return;
        }
        System.out.println("1、通过    2、不通过");
        int result = inputInt("请选择审核结果：");
        if (result != AUDIT_PASS && result != AUDIT_REJECT) {
            System.out.println("输入有误！");
            return;
        }
        b.setAuditstatus(result);
        b.setAuditperson(LoginController.currentUserName());
        b.setAudittime(new Date());

        if (!backdownService.updateBackdown(b)) {
            System.out.println("审核失败！");
            return;
        }
        if (result == AUDIT_PASS
                && (Objects.equals(b.getRetreattype(), RETREAT_NORMAL)
                || Objects.equals(b.getRetreattype(), RETREAT_DEATH))) {
            Customer c = customerService.findCustomerById(b.getCustomer_id());
            if (c != null && c.getBed_id() != null) {
                bedService.freeBed(c.getBed_id());
            }
        }
        System.out.println("审核完成！");
    }

    // ==================== 三、外出登记 ====================

    private static void outwardMenu() {
        while (true) {
            printTitle("外出登记");
            System.out.println("1、浏览外出登记信息");
            System.out.println("2、按客户姓名查询");
            System.out.println("3、审核外出申请");
            System.out.println("0、返回上层菜单");
            String select = input("请输入序号：");
            switch (select) {
                case "1":
                    printOutwards(outwardService.GetOutwards());
                    break;
                case "2":
                    String name = input("客户姓名（模糊）：");
                    List<Outward> filtered = new ArrayList<>();
                    for (Outward o : outwardService.GetOutwards()) {
                        String cName = customerNameOf(o.getCustomer_id());
                        if (cName != null && cName.contains(name)) {
                            filtered.add(o);
                        }
                    }
                    printOutwards(filtered);
                    break;
                case "3":
                    auditOutward();
                    break;
                case "0":
                    return;
                default:
                    System.out.println("输入有误，请重新输入！");
            }
        }
    }

    private static void printOutwards(List<Outward> list) {
        if (list == null || list.isEmpty()) {
            System.out.println("暂无外出登记信息！");
            return;
        }
        System.out.printf("%-5s%-10s%-12s%-12s%-12s%-16s%-8s%-10s%-12s%n",
                "ID", "客户ID", "客户姓名", "外出时间", "预计返回", "外出事由", "状态", "审批人", "审批时间");
        for (Outward o : list) {
            System.out.printf("%-5d%-10d%-12s%-12s%-12s%-16s%-8s%-10s%-12s%n",
                    o.getId(),
                    o.getCustomer_id(),
                    customerNameOf(o.getCustomer_id()),
                    fmt(o.getOutgoingtime()),
                    fmt(o.getExpectedreturntime()),
                    o.getOutgoingreason(),
                    auditText(o.getAuditstatus()),
                    o.getAuditperson(),
                    fmt(o.getAudittime()));
        }
    }

    /** 审核外出：通过时把客户正在使用的床位状态改为"外出" */
    private static void auditOutward() {
        int id = inputInt("请输入要审核的外出登记ID：");
        Outward o = outwardService.GetOutwardById(id);
        if (o == null) {
            System.out.println("外出登记不存在！");
            return;
        }
        if (o.getAuditstatus() != null && o.getAuditstatus() != 0) {
            System.out.println("该申请已审核，不能重复审核！");
            return;
        }
        System.out.println("1、通过    2、不通过");
        int result = inputInt("请选择审核结果：");
        if (result != AUDIT_PASS && result != AUDIT_REJECT) {
            System.out.println("输入有误！");
            return;
        }
        o.setAuditstatus(result);
        o.setAuditperson(LoginController.currentUserName());
        o.setAudittime(new Date());

        if (!outwardService.UpdateOutward(o)) {
            System.out.println("审核失败！");
            return;
        }
        if (result == AUDIT_PASS) {
            Customer c = customerService.findCustomerById(o.getCustomer_id());
            if (c != null && c.getBed_id() != null) {
                bedService.changeBedStatus(c.getBed_id(),1);
            }
        }
        System.out.println("审核完成！");
    }

    // ==================== 私有工具 ====================

    private static boolean isNurseCustomer(Customer c) {
        //护理老人=配置了护理项目的客户；自理老人=没有配置护理项目
        return nurseItemService.findCustomerIdsWithNurseItems().contains(c.getId());
    }

    private static String customerNameOf(Integer customerId) {
        if (customerId == null) {
            return "";
        }
        Customer c = customerService.findCustomerById(customerId);
        return c == null ? "" : c.getCustomer_name();
    }

    private static boolean containsRoom(Map<String, List<String>> rooms, String roomNo) {
        for (List<String> nos : rooms.values()) {
            if (nos.contains(roomNo)) {
                return true;
            }
        }
        return false;
    }

    private static int calcAge(Date birthday) {
        LocalDate b = birthday.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        return Period.between(b, LocalDate.now()).getYears();
    }

    private static void printTitle(String title) {
        System.out.println();
        System.out.println("===== " + title + " =====");
    }

    private static String input(String tip) {
        System.out.print(tip);
        return scanner.nextLine().trim();
    }

    private static int inputInt(String tip) {
        while (true) {
            try {
                return Integer.parseInt(input(tip));
            } catch (NumberFormatException e) {
                System.out.println("请输入数字！");
            }
        }
    }

    private static Integer inputIntOrNull(String tip) {
        String s = input(tip);
        return s.isEmpty() ? null : Integer.valueOf(s);
    }

    private static Date parseDate(String s) {
        if (s == null || s.isEmpty()) {
            return null;
        }
        try {
            return Tools.DATE_FORMAT.parse(s);
        } catch (ParseException e) {
            return null;
        }
    }

    private static String fmt(Date date) {
        return date == null ? "" : Tools.DATE_FORMAT.format(date);
    }

    private static String keep(String tip, String oldValue) {
        String s = input(tip);
        return s.isEmpty() ? oldValue : s;
    }

    private static Date keepDate(String tip, Date oldValue) throws ParseException {
        String s = input(tip);
        return s.isEmpty() ? oldValue : Tools.DATE_FORMAT.parse(s);
    }

    private static String sexText(Integer sex) {
        if (sex == null) {
            return "";
        }
        return sex == 0 ? "男" : "女";
    }

    private static String retreatTypeText(Integer type) {
        if (type == null) {
            return "";
        }
        switch (type) {
            case RETREAT_NORMAL:
                return "正常退住";
            case RETREAT_DEATH:
                return "死亡退住";
            case RETREAT_KEEP_BED:
                return "保留床位";
            default:
                return "未知";
        }
    }

    private static String auditText(Integer status) {
        if (status == null || status == 0) {
            return "待审核";
        }
        return status == AUDIT_PASS ? "通过" : "不通过";
    }

}
