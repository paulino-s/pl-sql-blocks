CREATE TABLESPACE clinica_tsp
  DATAFILE 'UESclinica.dbf'
  SIZE 20M AUTOEXTEND ON;


  /*Por el tiempo no se agregó, pero sería de la siguiente manera, esto para cada table, indice y restriccion*/

  TABLESPACE tbs1

  /*POR EJEMPLO: para la tabla clinica quedará*/

  TABLESPACE clinica_tsp


/*'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''*/
create or replace function numero_pacientes_clinica(id_cli datos_clinica.id_clinica%type) return integer
as
    total_pacientes integer;
begin
    select count(*) into total_pacientes  from paciente where id_clinica = id_cli;
    return total_pacientes;
end;

/*'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''*/

create or replace trigger actualizar_stats 
after insert 
on paciente
for each row
begin
    if inserting then
        update estadisticas set cantidad_atendidos = (cantidad_atendidos + 1) where id_estadistica = :new.id_clinica;  
    end if;
end;
/*'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''*/

create or replace trigger bitacoralogin
after insert or delete or update on 
login
referencing old as old new as new 
for each row declare begin 
 if inserting then 
 Insert into bitacora(usuario,contra) 
values('inserto',:new.user,password); end if; 
 if deleting then 
 Insert into bitacora(usuario,contra) 
values('elimino',:old.user,password); end if; 
 if updating then 
 Insert into bitacora(usuario, contra) 
values('modifico',:old.user, password); 
end if; 
end; 

/*'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''*/

create or replace package vars
as
    cursor c_pacientes_mayores is select * from paciente where 
        trunc(months_between(sysdate,fecha_naciemiento)/12) > 50;
    cursor nomina_doctores is select * from doctores;
    cursor doctores_clinica(id_cli datos_clinica.id_clinica%type) 
        is select * from doctores d, datos_clinica c
            where c.id_clinica = id_cli and d.id_clinica = c.id_clinica;
    cursor citas_programadas(f citas.fecha%type) is select * from citas 
        where fecha = f;
    cursor historial_paciente(paciente_id paciente.id_paciente%type) 
        is select * from paciente p, historial h
            where p.id_paciente = h.id_paciente;
end vars;

/*'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''*/
create or replace procedure filtrar_pacientes(filtro integer)
is
    pac paciente%rowtype;
begin
    case filtro
        when 1 then
            for pac in (select * from paciente order by fecha_naciemiento) loop
                dbms_output.put_line(pac.nombre||''||pac.apellido);
            end loop;
        when 2 then 
            for pac in (select * from paciente order by direccion) loop
                dbms_output.put_line(pac.nombre||''||pac.apellido);
            end loop;
        end case;
end;
/*'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''*/

/*LITERAL 1 */

create or replace function total_ingrersos_consulta 
return ingresos.cantidad_pagar%type
is
    total ingresos.cantidad_pagar%type;
begin
    select sum(nvl(cantidad_pagar,0)) into total from ingresos;
    return total;
end;


/*LITERAL 2 */
create or replace function total_ingrersos_hospitalizacion
return ingresos.cantidad_hospital%type
is
    total ingresos.cantidad_hospital%type;
begin
    select sum(nvl(cantidad_hospital,0)) into total from ingresos;
    return total;
end;
/*'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''*/
