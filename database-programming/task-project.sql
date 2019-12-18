-- Design and implement a database system. Topic: Hotel database

-- Note the following guidelines:
-- Grade 3
    -- - at least 5 tables should be defined.
    -- - the database schema reflects all the attributes and dependencies of the “real” objects within the given topic.
    -- - there are relationships between tables based on primary and foreign keys.
    -- - sample data are provided for all the tables,
    -- - at least 10 SQL queries for data preview should be defined; aggregate functions and SQL clauses should be considered,
    -- - at least 3 procedures performing different operations should be defined (e.g. for adding, modification, and retrieving data from the database)
    -- - functions that enable calculations should be defined (at least 2).

-- Grade 4
    -- - all requirements for the assessment of 3, plus:
    -- - definitions of procedures and functions should prove your high database skills (complexity, 'if' statements, loops, cursors, handling exceptions ...) and should differ in data they work on, operations they perform, and attributes they accept.

-- Grade 5
    -- - all requirements for the assessment of 4, plus:
    -- - at least 3 tables should have triggers defined,
    -- - additional database structures should be defined, e.g. packages, database scheduler, ...

-- Note: No interface is required (except for standard database output).



CREATE TABLE jobs ( 
    job_id          NUMBER NOT NULL PRIMARY KEY, 
    job_title       VARCHAR2(35) NOT NULL, 
    min_salary      NUMBER(6),
    max_salary      NUMBER(6)
);

INSERT INTO jobs VALUES (1, 'Owner', null, null);
INSERT INTO jobs VALUES (2, 'Flat surfaces maintainer', 2000, 3000);
INSERT INTO jobs VALUES (3, 'Doorkeeper ', 2000, 5000);
INSERT INTO jobs VALUES (4, 'Junior assistant', 1000, 2000);   



CREATE TABLE employees ( 
    employee_id     NUMBER NOT NULL PRIMARY KEY, 
    first_name      VARCHAR2(20) NOT NULL, 
    last_name       VARCHAR2(25) NOT NULL,
    email           VARCHAR2(25) NOT NULL,
    phone_number    VARCHAR2(20) NOT NULL, 
    hire_date       DATE NOT NULL,
    salary          NUMBER(8),
    job_id          NUMBER NOT NULL,
    supervisor_id   NUMBER, 
    CONSTRAINT      e_s_min         CHECK (salary > 0), 
    CONSTRAINT      e_j_fk          FOREIGN KEY (job_id) REFERENCES jobs (job_id), 
    CONSTRAINT      e_s_fk          FOREIGN KEY (supervisor_id) REFERENCES employees
);

INSERT INTO employees VALUES (1, 'Jan', 'Kowalski', 'sking@hotel.com', '+48 123 456 789', TO_DATE('2015-12-01', 'yyyy-mm-dd'), 8900, 1, null);

INSERT INTO employees VALUES (2, 'Neena', 'Kochhar', 'asdhf@hotel.com', '+48 123 456 789', TO_DATE('2015-12-01', 'yyyy-mm-dd'), 2500, 2, 1);
INSERT INTO employees VALUES (3, 'Diana', 'Lorentz', 'sking@hotel.com', '+48 123 456 789', TO_DATE('2015-12-01', 'yyyy-mm-dd'), 2500, 2, 1);

INSERT INTO employees VALUES (4, 'Alexander', 'Hunold', 'asdfg@hotel.com', '+48 123 456 789', TO_DATE('2015-12-01', 'yyyy-mm-dd'), 3900, 3, 1);
INSERT INTO employees VALUES (5, 'Bruce', 'Ernst', 'sbhikf@hotel.com', '+48 123 456 789', TO_DATE('2015-12-01', 'yyyy-mm-dd'), 3900, 3, 1);
INSERT INTO employees VALUES (6, 'David', 'Austin', 'efyn@hotel.com', '+48 123 456 789', TO_DATE('2016-06-01', 'yyyy-mm-dd'), 3900, 3, 1);

INSERT INTO employees VALUES (7, 'Nancy', 'Valli', 'juynh@hotel.com', '+48 123 456 789', TO_DATE('2019-09-01', 'yyyy-mm-dd'), 1500, 4, 5);
INSERT INTO employees VALUES (8, 'Daniel', 'Greenberg', 'tyb@hotel.com', '+48 123 456 789', TO_DATE('2019-11-01', 'yyyy-mm-dd'), 1500, 4, 6);



CREATE TABLE guests ( 
    guest_id        NUMBER NOT NULL PRIMARY KEY, 
    first_name      VARCHAR2(20) NOT NULL, 
    last_name       VARCHAR2(25) NOT NULL,
    email           VARCHAR2(25),
    phone_number    VARCHAR2(20), 
    CONSTRAINT      g_p_e_nn  CHECK (email IS NOT NULL OR phone_number IS NOT NULL)
);

INSERT INTO guests VALUES (1, 'John', 'Chen', 'bbbbdf@hotel.com', '+48 123 456 789');
INSERT INTO guests VALUES (2, 'Ismael', 'Sciarra', 'reberb@hotel.com', '+48 123 456 789');
INSERT INTO guests VALUES (3, 'Luis', 'Popp', 'erb234@hotel.com', '+48 123 456 789');
INSERT INTO guests VALUES (4, 'Den', 'Raphaely', 'ss2s34@hotel.com', '+48 123 456 789');
INSERT INTO guests VALUES (5, 'Alexander', 'Khoo', 'ewfumyntbr@hotel.com', '+48 123 456 789');



CREATE TABLE beds ( 
    bed_id          NUMBER NOT NULL PRIMARY KEY,
    bed_type        VARCHAR2(10) NOT NULL CHECK (bed_type IN ('for kids', 'sofa', 'normal', 'luxurious')),
    capacity        NUMBER(1) NOT NULL
);

INSERT INTO beds VALUES (1, 'for kids', 1);
INSERT INTO beds VALUES (2, 'sofa', 1);
INSERT INTO beds VALUES (3, 'sofa', 2);
INSERT INTO beds VALUES (4, 'normal', 1);
INSERT INTO beds VALUES (5, 'normal', 2);
INSERT INTO beds VALUES (6, 'luxurious', 1);
INSERT INTO beds VALUES (7, 'luxurious', 2);



CREATE TABLE rooms ( 
    room_id         NUMBER NOT NULL PRIMARY KEY, 
    capacity        NUMBER(2) NOT NULL, 
    has_bathroom    NUMBER(1,0) DEFAULT 0,
    smoking_allowed NUMBER(1,0) DEFAULT 0,
    pets_allowed    NUMBER(1,0) DEFAULT 0,
    costs_per_day   NUMBER(6) NOT NULL,
    maintainer_id   NUMBER,
    CONSTRAINT      r_m_fk  FOREIGN KEY (maintainer_id) REFERENCES employees
);

INSERT INTO rooms VALUES (1, 3, 0, 1, 1, 50, 2);
INSERT INTO rooms VALUES (2, 5, 1, 1, 1, 100, 2);
INSERT INTO rooms VALUES (3, 8, 1, 0, 0, 200, 2);
INSERT INTO rooms VALUES (4, 8, 1, 0, 0, 250, 2);
INSERT INTO rooms VALUES (5, 1, 1, 1, 1, 60, 3);
INSERT INTO rooms VALUES (6, 1, 1, 1, 1, 60, 3);
INSERT INTO rooms VALUES (7, 1, 1, 1, 1, 80, 3);
INSERT INTO rooms VALUES (8, 1, 1, 1, 1, 150, 3);
INSERT INTO rooms VALUES (9, 2, 1, 1, 1, 250, 3);



CREATE TABLE bedsToRooms ( 
    bed_id          NUMBER,
    room_id         NUMBER,
    amount          NUMBER,
    CONSTRAINT      b_b_i_fk  FOREIGN KEY (bed_id) REFERENCES beds,
    CONSTRAINT      b_r_i_fk  FOREIGN KEY (room_id) REFERENCES rooms
);

INSERT INTO bedsToRooms VALUES (1, 1, 1);
INSERT INTO bedsToRooms VALUES (1, 3, 1);

INSERT INTO bedsToRooms VALUES (2, 4, 1);
INSERT INTO bedsToRooms VALUES (2, 5, 2);

INSERT INTO bedsToRooms VALUES (3, 1, 8);

INSERT INTO bedsToRooms VALUES (4, 4,8);

INSERT INTO bedsToRooms VALUES (5, 4, 1);

INSERT INTO bedsToRooms VALUES (6, 4, 1);

INSERT INTO bedsToRooms VALUES (7, 4, 2);

INSERT INTO bedsToRooms VALUES (8, 6, 1);

INSERT INTO bedsToRooms VALUES (9, 7, 1);



CREATE TABLE reservations ( 
    reservation_id  NUMBER NOT NULL PRIMARY KEY,
    check_in_date   DATE NOT NULL,
    check_out_date  DATE NOT NULL,
    extra_costs     NUMBER(6),
    payment_status  VARCHAR2(10) NOT NULL CHECK (payment_status IN ('pending', 'paid', 'canceled')),
    room_id         NUMBER NOT NULL,
    guest_id        NUMBER NOT NULL,
    CONSTRAINT      r_gt_i_fk     FOREIGN KEY (guest_id) REFERENCES guests,
    CONSTRAINT      r_r_i_fk      FOREIGN KEY (room_id) REFERENCES rooms
);

INSERT INTO reservations VALUES (1, TO_DATE('2019-12-01', 'yyyy-mm-dd'), TO_DATE('2019-12-08', 'yyyy-mm-dd'), 50, 'paid', 7, 1);
INSERT INTO reservations VALUES (2, TO_DATE('2019-12-14', 'yyyy-mm-dd'), TO_DATE('2020-01-02', 'yyyy-mm-dd'), 300, 'pending', 9, 1);

INSERT INTO reservations VALUES (3, TO_DATE('2018-11-14', 'yyyy-mm-dd'), TO_DATE('2018-11-30', 'yyyy-mm-dd'), 0, 'paid', 7, 2);
INSERT INTO reservations VALUES (4, TO_DATE('2019-12-14', 'yyyy-mm-dd'), TO_DATE('2019-12-30', 'yyyy-mm-dd'), 50, 'pending', 7, 2);

INSERT INTO reservations VALUES (5, TO_DATE('2019-12-01', 'yyyy-mm-dd'), TO_DATE('2019-01-08', 'yyyy-mm-dd'), 0, 'pending', 1, 3);

INSERT INTO reservations VALUES (6, TO_DATE('2019-12-01', 'yyyy-mm-dd'), TO_DATE('2019-12-30', 'yyyy-mm-dd'), 0, 'pending', 3, 4);
INSERT INTO reservations VALUES (7, TO_DATE('2019-12-01', 'yyyy-mm-dd'), TO_DATE('2019-12-30', 'yyyy-mm-dd'), 1000, 'pending', 4, 4);
INSERT INTO reservations VALUES (8, TO_DATE('2019-12-01', 'yyyy-mm-dd'), TO_DATE('2019-12-30', 'yyyy-mm-dd'), 100, 'pending', 5, 4);
INSERT INTO reservations VALUES (9, TO_DATE('2019-12-01', 'yyyy-mm-dd'), TO_DATE('2019-12-30', 'yyyy-mm-dd'), 50, 'pending', 6, 4);

INSERT INTO reservations VALUES (10, TO_DATE('2019-10-01', 'yyyy-mm-dd'), TO_DATE('2019-10-17', 'yyyy-mm-dd'), 50, 'paid', 2, 5);



TODO: 
    at least 3 procedures performing different operations should be defined (e.g. for adding, modification, and retrieving data from the database)
        - checkIfRoomAvailable(check_in_date DATE, check_out_date DATE)
        - addReservation(...)
        - add_employee(...)
        - ?...?



create or replace procedure add_reservation (p_check_in_date date,
                                             p_check_out_date date,
                                             p_room_id number,
                                             p_guest_id number) is 
begin

    if is_room_available(p_check_in_date, p_check_out_date, p_room_id) = 0 then
        raise_application_error(-20002, 'Room is already booked in this time!');
    end if;

    insert into reservations values (reservations.nextval, p_check_in_date, p_check_out_date, 0, 'pending', p_room_id, p_guest_id);
    
end;

create or replace procedure add_extra_costs (p_added_amount number,
                                             p_reservation_id number) is 
v_current_extra_costs number;
v_payment_status reservations.payment_status%type;
begin

    select payment_status, extra_costs into v_payment_status from reservations where reservation_id = p_reservation_id;

    if v_payment_status != 'pending' then
        raise_application_error(-20002, 'Cannot add additional costs');
    end if;

    update reservations set extra_costs = v_current_extra_costs + p_added_amount
    where reservation_id = p_reservation_id;
 
end;


create or replace procedure add_employee (p_first_name employees.first_name%type,
                                          p_last_name employees.last_name%type,
                                          p_email employees.email%type,
                                          p_phone_number employees.phone_number%type,
                                          p_salary employees.salary%type,
                                          p_job_id employees.job_id%type,
                                          p_supervisor_id employees.supervisor_id%type) is 
e_no_such_supervisor exception;
e_no_such_job exception;
v_row_count number;
v_min_sal number;
v_max_sal number;
begin

    if (p_supervisor_id is not null) then
        select count(*) into v_row_count from employees where employee_id = p_supervisor_id;
        if v_row_count = 0 then
            raise e_no_such_supervisor;
        end if;
    end if;

    select count(*) into v_row_count from jobs where job_id = p_job_id;
    if v_row_count = 0 then
        raise e_no_such_job;
    end if;

    select min_salary, max_salary into v_min_sal, v_max_sal from jobs where job_id = p_job_id;
    if p_salary > v_max_sal or p_salary < v_min_sal then
        raise_application_error(-20001, 'Wrong salary value!');
    end if;
    
    INSERT INTO employees VALUES (employees_seq.nextval, p_first_name, p_last_name, p_email, p_phone_number, to_char(sysdate,'yyyy-mm-dd'), p_salary, p_job_id, p_supervisor_id);

    exception
        when e_no_such_supervisor then 
            dbms_output.put_line('No such supervisor!');
        when e_no_such_job then 
            dbms_output.put_line('No such job!');

end;

    at least 10 SQL queries for data preview should be defined; aggregate functions and SQL clauses should be considered,
        - ...
    
    at least 2 functions that enable calculations should be defined
        - ...



create or replace function is_room_available (p_room_id number,
                                                    p_check_in_date date,
                                                    p_check_out_date date) 
return number is
v_check_in_date date;
v_check_out_date date;
begin
    select check_in_date, check_out_date into v_check_out_date from reservations where room_id = p_room_id;
    if sql%rowcount = 0 then
        return 1;
    end if;

    if trunc(sysdate) between v_check_in_date and v_check_out_date then
        return 0;
    end if;

    return 1;
end;
