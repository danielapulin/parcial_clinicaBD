#  Sistema de Gestión de Clínica Privada

Proyecto desarrollado para el **Segundo Examen Parcial de Base de Datos I**. El sistema modela y gestiona la administración integral de una clínica privada, abarcando desde el diseño relacional normalizado hasta la implementación física en MySQL y operaciones CRUD programadas en Python utilizando el ORM Peewee.

---

##  Integrantes del Grupo (4 Integrantes)
* **Integrante 1:** Gabriela Nieva
* **Integrante 2:** Belen Mancilla
* **Integrante 3:** Matias Villegas
* **Integrante 4:** Daniela Pulin

---

##  Stack Tecnológico
* **Base de Datos:** MySQL (DDL, DCL y restricciones de integridad).
* **Lenguaje de Programación:** Python 3.
* **ORM:** Peewee (para el mapeo objeto-relacional y consultas CRUD).
* **Control de Versiones:** Git y GitHub.

---

##  Estructura del Repositorio

```text
proyecto-base-de-datos-clinica/
│
├── sql/
│   └── clinica_privada.sql          # Script DDL, DCL (usuarios/permisos) y creación de tablas
│
├── src/
│   └── main.py                      # Script en Python con operaciones CRUD (Peewee)
│
├── docs/
│   └── documentacion_parcial.pdf    # Documentación técnica completa y retrospectiva
│
├── assets/
│   ├── der_conceptual.png           # Modelo Conceptual (Notación de Chen)
│   └── der_fisico.png               # Modelo Físico / DER del SGBD
│
└── README.md                        # Descripción general del proyecto y guía de ejecución