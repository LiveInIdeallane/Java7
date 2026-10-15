package service.LoginServiceS;


import entity.UserS.User;

public interface LoginService {
    User login(String username, String password);
}
