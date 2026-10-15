package controller;

import java.util.Scanner;

public class MainView {

        private static Scanner scanner = new Scanner(System.in);
        public static void menu(){
            System.out.println("******");
            System.out.println("1、用户管理");
            System.out.println("2、客户管理");
            System.out.println("3、床位管理");
            System.out.println("4、护理管理");
            System.out.println("5、健康管家");
            System.out.println("0、退出系统");
            System.out.println("******");
            System.out.println("请输入序号：");
            int select = scanner.nextInt();
            switch (select){
                case 1:
                    break;
                case 2:
                    break;
                case 3:
                    break;
                case 4:
                    break;
                case 5:

                    break;
                case 0:
                    System.exit(0);
            }
        }
    }
}
