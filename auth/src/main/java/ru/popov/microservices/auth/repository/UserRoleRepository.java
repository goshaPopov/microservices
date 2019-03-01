package ru.popov.microservices.auth.repository;


import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.popov.microservices.auth.domain.UserRole;

/**
 * Created by imrenagi on 5/13/17.
 */
@Repository
public interface UserRoleRepository extends CrudRepository<UserRole, Long> {

}
