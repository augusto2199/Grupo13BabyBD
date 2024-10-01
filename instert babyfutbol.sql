USE `babyfutbol`;

INSERT INTO torneos (nombre) VALUES
					('toreno1');
                    
INSERT INTO roles (nombre) VALUES
					('Admin');

INSERT INTO roles (nombre) VALUES
					('Arbitro');

INSERT INTO roles (nombre) VALUES
					('Entrenador');

INSERT INTO roles (nombre) VALUES
					('Jugador');

INSERT INTO usuarios (nombre, apellido, email, password, edad, roles_id) VALUES
					('Augusto', 'Schulz', 'augustoschulz@davinci.edu.ar', '1234', 25, 5);