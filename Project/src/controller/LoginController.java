package controller;




import entity.UserS.User;
import service.LoginServiceS.LoginService;
import service.LoginServiceS.LoginServiceImpl;

import java.util.Scanner;

/**
 * 登录控制器
 */
public class LoginController {
    private static final Scanner scanner = new Scanner(System.in);
    private static final LoginService loginService = new LoginServiceImpl();

    public static void login() {
        System.out.println("==================== 东软颐养系统 ====================");
        System.out.println("欢迎使用东软颐养系统");
        System.out.print("请输入用户名：");
        String username = scanner.nextLine();
        System.out.print("请输入密码：");
        String password = scanner.nextLine();

        try {
            User user = loginService.login(username, password);
            if (user == null) {
                System.out.println("用户名或密码错误，请重新输入！");
                login();
            } else {
                System.out.println("登录成功，欢迎【" + user.getNickname() + "】使用东软颐养系统");

                if (user.getRoleId() == 1) {
                    MainView.menu();
                } else if (user.getRoleId() == 2) {
                    NurseView.nurseMenu();
                } else {
                    System.out.println("未知角色，无法进入系统。");
                    login();
                }
            }
        } catch (RuntimeException e) {
            System.out.println("登录异常：" + e.getMessage());
            login();
        }
    }
}
