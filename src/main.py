from peewee import *

# Conexion a la base de datos MySQL
db = MySQLDatabase('clinica_privada', user='admin_clinica', password='AdminClave2026*', host='localhost', port=3306)

class BaseModel(Model):
    class Meta:
        database = db

class Paciente(BaseModel):
    id_paciente = AutoField()
    nombre = CharField(max_length=50)
    apellido = CharField(max_length=50)
    dni = CharField(max_length=20, unique=True)
    cobertura_medica = CharField(max_length=50)

    class Meta:
        table_name = 'Paciente'

class Turno(BaseModel):
    id_turno = AutoField()
    fecha = DateField()
    hora = TimeField()
    estado = CharField(max_length=30)
    id_paciente = ForeignKeyField(Paciente, backref='turnos', column_name='id_paciente')

    class Meta:
        table_name = 'Turno'

# Establecer conexion
db.connect()

# 1. INSERT: Registrar un nuevo paciente
nuevo_paciente = Paciente.create(nombre='Sofia', apellido='Martinez', dni='38999888', cobertura_medica='OSDE')
print(f"-> INSERT exitoso. Paciente creado con ID: {nuevo_paciente.id_paciente}")

# 2. UPDATE: Actualizar la cobertura medica del paciente
Paciente.update(cobertura_medica='Swiss Medical').where(Paciente.dni == '38999888').execute()
print("-> UPDATE exitoso. Cobertura medica actualizada.")

# 3. SELECT: Consultar turnos uniendo las tablas Paciente y Turno (JOIN implicito en Peewee)
print("\n-> SELECT: Listado de Turnos y sus Pacientes:")
query = (Turno
         .select(Turno, Paciente)
         .join(Paciente))
for turno in query:
    print(f"Turno ID: {turno.id_turno} | Fecha: {turno.fecha} | Paciente: {turno.id_paciente.nombre} {turno.id_paciente.apellido}")

# 4. DELETE: Eliminar un registro de turno
Turno.delete().where(Turno.id_turno == 1).execute()
print("\n-> DELETE exitoso. Turno eliminado.")

db.close()