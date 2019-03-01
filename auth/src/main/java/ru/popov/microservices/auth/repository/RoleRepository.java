package ru.popov.microservices.auth.repository;


import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.popov.microservices.auth.domain.Role;

/**
 * Created by imrenagi on 5/12/17.
 */
@Repository
public interface RoleRepository extends CrudRepository<Role, Long> {
    Role findByName(String name);
}
