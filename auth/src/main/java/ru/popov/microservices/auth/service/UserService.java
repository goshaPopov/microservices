package ru.popov.microservices.auth.service;


import ru.popov.microservices.auth.domain.User;

/**
 * Created by imrenagi on 5/8/17.
 */
public interface UserService {
    void create(User user);
}
