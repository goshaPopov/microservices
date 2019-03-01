package ru.popov.microservices.auth.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.popov.microservices.auth.domain.User;

/**
 * Created by imrenagi on 5/8/17.
 */
@Repository
public interface UserRepository extends CrudRepository<User, Long> {
    User findByUsername(String username);
}
