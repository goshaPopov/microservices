CREATE TABLE IF NOT EXISTS users (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  first_name VARCHAR(255),
  last_name VARCHAR (255),
  is_enable TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL
);

CREATE UNIQUE INDEX email_index ON users (username);

CREATE TABLE IF NOT EXISTS roles (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL
);

CREATE TABLE IF NOT EXISTS permissions (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL
);

CREATE TABLE IF NOT EXISTS user_roles (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT NOT NULL,
  role_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (role_id) REFERENCES roles(id)
);


CREATE TABLE IF NOT EXISTS role_permissions (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  role_id BIGINT NOT NULL,
  permission_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL,
  FOREIGN KEY (role_id) REFERENCES roles(id),
  FOREIGN KEY (permission_id) REFERENCES permissions(id)
);


CREATE TABLE IF NOT EXISTS oauth_client_details (
  client_id VARCHAR(255) PRIMARY KEY,
  resource_ids VARCHAR(255),
  client_secret VARCHAR(255),
  scope VARCHAR(255),
  authorized_grant_types VARCHAR(255),
  web_server_redirect_uri VARCHAR(255),
  authorities VARCHAR(255),
  access_token_validity INTEGER,
  refresh_token_validity INTEGER,
  additional_information VARCHAR(4096),
  autoapprove tinyint
);

CREATE TABLE IF NOT EXISTS oauth_client_token (
  token_id VARCHAR(255),
  token BLOB,
  authentication_id VARCHAR(255),
  user_name VARCHAR(255),
  client_id VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS oauth_access_token (
  token_id VARCHAR(255),
  token BLOB,
  authentication_id VARCHAR(255),
  user_name VARCHAR(255),
  client_id VARCHAR(255),
  authentication BLOB,
  refresh_token VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS oauth_refresh_token (
  token_id VARCHAR(255),
  token BLOB,
  authentication BLOB
);

CREATE TABLE IF NOT EXISTS oauth_code (
  code VARCHAR(255), authentication BLOB
);

INSERT INTO oauth_client_details
    (client_id, client_secret, scope, authorized_grant_types,
     web_server_redirect_uri, authorities, access_token_validity,
     refresh_token_validity, additional_information, autoapprove)
VALUES
       ("browser", "", "ui",
        "password,refresh_token", null, null, 36000, 36000, null, true);
INSERT INTO oauth_client_details
    (client_id, client_secret, scope, authorized_grant_types,
     web_server_redirect_uri, authorities, access_token_validity,
     refresh_token_validity, additional_information, autoapprove)
VALUES
       ("service-account", "service-account", "server",
        "client_credentials,refresh_token", null, null, 36000, 36000, null, true);

INSERT INTO roles (id, name) VALUES (1, "ROLE_SUPER_ADMIN");
INSERT INTO roles (id, name) VALUES (2, "ROLE_ADMIN");
INSERT INTO roles (id, name) VALUES (3, "ROLE_USER");
INSERT INTO roles (id, name) VALUES (4, "ROLE_VENDOR");

INSERT INTO permissions (id, name) VALUES (1, "READ_BASIC_INFORMATION");
INSERT INTO permissions (id, name) VALUES (2, "WRITE_BASIC_INFORMATION");
INSERT INTO permissions (id, name) VALUES (3, "CREATE_USER");
INSERT INTO permissions (id, name) VALUES (4, "DELETE_USER");

INSERT INTO role_permissions (role_id, permission_id)
VALUES (1, 1), (1,2), (1,3), (1,4),
       (2, 1), (2,2), (2,3), (2,4),
       (3, 1), (3,2), (3,3),
       (4,1), (4,2);

CREATE INDEX token_id_index ON oauth_access_token (token_id);
CREATE INDEX authentication_id_index ON oauth_access_token (authentication_id);
CREATE INDEX refresh_token_index ON oauth_access_token (refresh_token);
CREATE INDEX user_name_index ON oauth_access_token (user_name);
CREATE INDEX client_id_index ON oauth_access_token (client_id);

CREATE INDEX token_id_index ON oauth_client_token(token_id);
CREATE INDEX authentication_id_index ON oauth_client_token (authentication_id);

CREATE INDEX token_id_index ON oauth_refresh_token (token_id);

CREATE INDEX client_id_index ON oauth_client_details(client_id);

CREATE INDEX code_index ON oauth_code (code);


CREATE INDEX role_permission_index ON role_permissions (role_id, permission_id);
CREATE INDEX user_role_index ON user_roles (user_id, role_id);

CREATE INDEX role_name_index ON roles (name);
CREATE INDEX permission_name_index ON permissions (name);