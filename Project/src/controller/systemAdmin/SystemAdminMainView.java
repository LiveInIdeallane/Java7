package controller.systemAdmin;

import java.util.Scanner;

/**
 * 主界面 Controller：登录成功后的主菜单，只做跳转。
 */
public class SystemAdminMainView {

    private static final Scanner scanner = new Scanner(System.in);

    public static void menu() {
        while (true) {
            System.out.println("********************************");
            System.out.println("      东软颐养中心管理系统");
            System.out.println("********************************");
            System.out.println("1、客户管理");
            System.out.println("2、用户管理");
            System.out.println("3、床位管理");
            System.out.println("4、护理管理");
            System.out.println("5、食物管理");
            System.out.println("0、退出系统");
            System.out.print("请输入序号：");

            String select = scanner.nextLine();
            switch (select) {
                case "1":
                    CustomerController.menu();
                    break;
                case "2":
                case "3":
                case "4":
                case "5":
                    System.out.println("【该模块】开发中...");
                    break;
                case "0":
                    System.out.println("感谢使用，再见！");
                    System.exit(0);
                    break;
                default:
                    System.out.println("输入有误，请重新输入！");
            }
        }
    }

}
