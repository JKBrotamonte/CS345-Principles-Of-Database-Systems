######
# Homework 4: Python + MySQL connection
# Solution file
# Ana Paula Chaves, CS 345
######

# Import your Connection class
from connection import Connection


# define the class Pilot
class Pilot:

    # __init__()
    # Parameters: self
    #             id: integer that represents the pilot's identification number
    #                 (primary key, default=0)
    #             name: string that represents the pilot's name (default=""),
    #             salary: decimal that represents the pilot's salary
    #                     (default=0.0)
    #             bonus: decimal that represents the pilot's gratification
    #                    (default=0.0)
    #             airline: string that represents the airline company to which
    #                      the pilot is affiliated (default="")
    #             country: string that represents the country of residence. The
    #                      country indicates where the pilot is based (may not
    #                      be their country of birth, default="")
    #             config_dic: dictionary with the database configuration
    # Return: None
    def __init__(self, config_dic, id=0, name="", salary=0.0, bonus=0.0, airline="", country=""):
        self.__id = id
        self.__name = name
        self.__salary = salary
        self.__bonus = bonus
        self.__airline = airline
        self.__country = country
        self.__config = config_dic

    # __str__()
    # Prints the object Pilot in a nicely formatted string
    # Parameters: self
    # Return: a string in the format "Pilot <identification>: <name>"
    def __str__(self):
        return "Pilot " + str(self.get_id()) + ": " \
               + self.get_name()

    # set_id()
    # Process: sets the pilot's identification to the value in the parameter
    # Parameters: self
    #             id: the new identification number
    # Return: None
    def set_id(self, id):
        self.__id = id

    # set_name()
    # Process: sets the pilot's name to the value in the parameter
    # Parameters: self
    #             name: the new name
    # Return: None
    def set_name(self, name):
        self.__name = name

    # set_salary()
    # Process: sets the pilot's salary to the value in the parameter
    # Parameters: self
    #             salary: the new salary (as float)
    # Return: None
    def set_salary(self, salary):
        self.__salary = float(salary)

    # set_bonus()
    # Process: sets the pilot's bonus to the value in the parameter
    # Parameters: self
    #             bonus: the new bonus (as float)
    # Return: None
    def set_bonus(self, bonus):
        self.__bonus = float(bonus)

    # set_airline()
    # Process: sets the pilot's affiliation to the value in the parameter
    # Parameters: self
    #             airline: the new airline
    # Return: None
    def set_airline(self, airline):
        self.__airline = airline

    # set_country()
    # Process: sets the pilot's country to the value in the parameter
    # Parameters: self
    #             country: the new country or residence
    # Return: None
    def set_country(self, country):
        self.__country = country

    # get_id()
    # Process: returns the pilot's identification number
    # Parameters: self
    # Return: self.__id
    def get_id(self):
        return self.__id

    # get_name()
    # Process: returns the pilot's name
    # Parameters: self
    # Return: self.__name
    def get_name(self):
        return self.__name

    # get_salary()
    # Process: returns the pilot's salary
    # Parameters: self
    # Return: self.__salary
    def get_salary(self):
        return self.__salary

    # get_bonus()
    # Process: returns the pilot's gratification
    # Parameters: self
    # Return: self.__bonus
    def get_bonus(self):
        return self.__bonus

    # get_airline()
    # Process: returns the pilot's affiliation
    # Parameters: self
    # Return: self.__airline
    def get_airline(self):
        return self.__airline

    # get_country()
    # Process: returns the pilot's country
    # Parameters: self
    # Return: self.__country
    def get_country(self):
        return self.__country

    # save()
    # Process: create a Connection object (the class we created in file
    #               connection.py) by calling its constructor
    #               and passing the config dictionary as argument
    #          check if the pilot's identification number exists in the Pilot
    #               table
    #          if the identification number does NOT exist, insert the pilot as
    #               a new tuple in the Pilot table
    #          otherwise, update the existing tuple with the current values for
    #               this Pilot
    #          Note: always insert/update all the Pilot's attributes, as we are
    #                not keeping track of which ones changed
    # Parameters: self
    # Return: True if the execution of the SQL statement successfully affected
    #               one row in the Pilot table (one pilot inserted or updated)
    #         False, otherwise
    def save(self):
        # - creates a Connection object (the class we created in file connection.py)
        conn = Connection(self.__config)
        # - check if the pilot's identification number exists in the table airline_db.Pilot
        sql = "select * from pilot where identification = %s"
        values = [self.get_id()]
        result = list(conn.run_select(sql, values))
        # if the length of my result list is greater than zero, pilot exists in the Pilot table
        if len(result) > 0:
            # the pilot exists
            # use the appropriate function from Connection to update*** the existing
            #     tuple with the current values for this Pilot.
            sql = "update pilot set identification = %s, pilot_name = %s, \
            salary = %s, gratification = %s, airline_name = %s, country = %s \
            where identification = %s"
            values = [str(self.get_id()), str(self.get_name()), str(self.get_salary()), str(self.get_bonus()),
                      str(self.get_airline()), str(self.get_country()), str(self.get_id())]
        else:
            # the pilot does NOT exist in the Pilot table
            sql = "insert into pilot(identification, pilot_name, salary, gratification, \
            airline_name, country) values (%s, %s, %s, %s, %s, %s)"
            values = [str(self.get_id()), str(self.get_name()), str(self.get_salary()), str(self.get_bonus()),
                      str(self.get_airline()), str(self.get_country())]
        # call run_change from Connection with the sql and values I created in the if/else statement
        result = conn.run_change(sql, values)
        if result == 1:
            return True
        else:
            return False

    # remove()
    # Process: create a Connection object (the class we created in file
    #               connection.py) by calling its constructor and
    #               passing the config dictionary as argument
    #          delete the pilot based on the pilot's identification number
    # Parameters: self
    # Return: True if the execution of the SQL statement successfully affected
    #               one row in the Pilot table (one pilot removed)
    #         False, otherwise
    def remove(self):
        conn = Connection(self.__config)
        sql = "delete from pilot where identification = %s"
        values = [self.get_id()]
        result = conn.run_change(sql, values)
        if result == 1:
            return True
        else:
            return False

    # load()
    # Process: create a Connection object (the class we created in file
    #               connection.py) by calling its constructor and
    #               passing the config dictionary as argument
    #          find an existing pilot based on the pilot's identification
    #               number provided as argument
    #          if the returned result set contains an existing Pilot tuple, set
    #               the attributes of the pilot object to the values in the
    #               result set
    # Parameters: self
    #             id: integer value that represents the pilot's identification
    #                   number
    # Return: True if the pilot is successfully loaded with values retrieved
    #               from the Pilot table
    #         False otherwise
    def load(self, id):
        conn = Connection(self.__config)
        sql = "select * from pilot where identification = %s"
        values = [str(id)]
        result = conn.run_select(sql, values)
        if len(result) > 0:
            # get the first row from the resulting table
            # note that this result table has only one row because identification is PK
            result = result[0]
            # set the pilot attributes with whatever I got from the result[0]
            self.set_id(result[0])
            self.set_name(result[1])
            self.set_salary(result[2])
            self.set_bonus(result[3])
            self.set_airline(result[4])
            self.set_country(result[5])
            return True
        else:
            return False

# TODO 1. define the class Airport as specified on the assignment description
#  # 1.1. __init__()
#  # 1.2. __str__()
#  # 1.3. set_ and get_ for each attribute in Airport table
#  # 1.4. save()
#  # 1.5. load()
#  # 1.6. remove()
class Airport:
    def __init__(self, config_dic, acronym="", name="", city="", country=""):
        self.__acronym = acronym
        self.__name = name
        self.__city = city
        self.__country = country
        self.__config = config_dic
    
    def __str__(self):
        return "Airport " + self.get_acronym() + ": " \
               + self.get_name()
    
    # set and get for each attribute in airport table
    def set_acronym(self, acronym):
        self.__acronym = acronym

    def set_name(self, name):
        self.__name = name

    def set_city(self, city):
        self.__city = city

    def set_country(self, country):
        self.__country = country
    
    # get for each attribute in airport table
    def get_acronym(self):
        return self.__acronym

    def get_name(self):
        return self.__name

    def get_city(self):
        return self.__city

    def get_country(self,):
        return self.__country

    # save()
    def save(self):
        # - creates a Connection object (the class we created in file connection.py)
        conn = Connection(self.__config)
        # - check if the airport's acronym exists in the table airline_db.Airport
        sql = "select * from airport where acronym = %s"
        values = [self.get_acronym()]
        result = list(conn.run_select(sql, values))
        # if the length of my result list is greater than zero, airport exists in airport table
        if len(result) > 0:
            # the airport exists
            # use the appropriate function from Connection to update*** the existing
            #     tuple with the current values for this airport.
            sql = "update airport set acronym = %s, airport_name = %s, \
            city = %s, country = %s \
            where acronym = %s"
            values = [str(self.get_acronym()), str(self.get_name()), str(self.get_city()), str(self.get_country()), str(self.get_acronym())]
        else:
            # the airport does NOT exist in the airport table
            sql = "insert into airport(acronym, airport_name, city, country) values (%s, %s, %s, %s)"
            values = [str(self.get_acronym()), str(self.get_name()), str(self.get_city()), str(self.get_country())]
        # call run_change from Connection with the sql and values I created in the if/else statement
        result = conn.run_change(sql, values)
        if result == 1:
            return True
        else:
            return False

    # load()
    def load(self, acronym):
        conn = Connection(self.__config)
        sql = "select * from airport where acronym = %s"
        values = [str(acronym)]
        result = conn.run_select(sql, values)
        if len(result) > 0:
            # get the first row from the resulting table
            result = result[0]
            # set the airport attributes with whatever I got from the result[0]
            self.set_acronym(result[0])
            self.set_name(result[1])
            self.set_city(result[2])
            self.set_country(result[4])
            return True
        else:
            return False

    # remove()
    def remove(self):
        conn = Connection(self.__config)
        sql = "delete from airport where acronym = %s"
        values = [self.get_acronym()]
        result = conn.run_change(sql, values)
        if result == 1:
            return True
        else:
            return False


# TODO 2. define the class Stopover as specified on the assignment description
#  # 2.1. __init__()
#  # 2.2. __str__()
#  # 2.3. set_ and get_ for each attribute in Stopover table
#  # 2.4. save()
#  # 2.5. load()
#  # 2.6. remove()
class Stopover:
    def __init__(self, config_dic, number=None, date="", id=None, aircraft=""):
        self.__number = None
        self.__date = date
        self.__id = None
        self.__aircraft = aircraft
        self.__config = config_dic

        if number is not None:
            self.set_number(number)

        if id is not None:
            self.set_id(id)

    def __str__(self):
        return "Stopover " + self.get_number() + " (on " \
               + self.get_date() + ")"

    # set for each attribute in stopover table
    def set_number(self, number):
        self.__number = Flight(self.__config)
        self.__number.load(number)

    def set_date(self, date):
        self.__date = date

    def set_id(self, id):
        self.__id = Pilot(self.__config)
        self.__id.load(id)

    def set_aircraft(self, aircraft):
        self.__aircraft = aircraft

    # get for each attribute in stopover table
    def get_number(self):
        return self.__number

    def get_date(self):
        return self.__date

    def get_id(self):
        return self.__id

    def get_aircraft(self):
        return self.__aircraft
    
    # save()
    def save(self):
        # - creates a Connection object (the class we created in file connection.py)
        conn = Connection(self.__config)
        # - check if the stopover's flight number and flight date exists in the table airline_db.Stopover
        sql = "select * from stopover where flight_number = %s AND flight_date = %s"
        values = [self.get_number(), self.get_date()]
        result = list(conn.run_select(sql, values))
        # if the length of my result list is greater than zero, stopover exists in the stopover table
        if len(result) > 0:
            # the stopover exists
            # use the appropriate function from Connection to update*** the existing
            #     tuple with the current values for this stopover.
            sql = "update stopover set flight_number = %s, flight_date = %s, \
            pilot_id = %s, aircraft = %s \
            where flight_number = %s AND flight_date = %s"
            values = [str(self.get_number()), str(self.get_date()), str(self.get_id()), str(self.get_aircraft()),
                      str(self.get_number()), str(self.get_date())]
        else:
            # the stopover does NOT exist in the stopover table
            sql = "insert into stopover(flight_number, flight_date, pilot_id, aircraft) values (%s, %s, %s, %s)"
            values = [str(self.get_number()), str(self.get_date()), str(self.get_id()), str(self.get_aircraft())]
        # call run_change from Connection with the sql and values I created in the if/else statement
        result = conn.run_change(sql, values)
        if result == 1:
            return True
        else:
            return False
    
    # load()
    def load(self, number, date):
        conn = Connection(self.__config)
        sql = "select * from stopover where flight_number = %s AND flight_date = %s"
        values = [str(number), str(date)]
        result = conn.run_select(sql, values)
        if len(result) > 0:
            # get the first row from the resulting table
            result = result[0]
            # set the pilot attributes with whatever I got from the result[0]
            self.set_number(result[0])
            self.set_date(result[1])
            self.set_id(result[2])
            self.set_aircraft(result[3])
            return True
        else:
            return False

    # remove()
    def remove(self):
        conn = Connection(self.__config)
        sql = "delete from stopover where flight_number = %s AND flight_date = %s"
        values = [self.get_number(), self.get_date()]
        result = conn.run_change(sql, values)
        if result == 1:
            return True
        else:
            return False

# TODO 3. define the class Flight as specified on the assignment description
#  # 3.1. __init__()
#  # 3.2. __str__()
#  # 3.3. set_ and get_ for each attribute in Flight table
#  # 3.4. save()
#  # 3.5. load()
#  # 3.6. remove()
class Flight:
    def __init__(self, config_dic, number="", departure=None, destination=None, time=""):
        self.__number = number
        self.__departure = None
        self.__destination = None
        self.__time = time
        self.__config = config_dic

        if departure is not None:
            self.set_departure()

        if destination is not None:
            self.set_destination()

    def __str__(self):
        return "Flight " + str(self.get_number()) + ": " \
               + self.get_departure() + " to " + self.get_destination()

    # set for each attribute in flight table
    def set_number(self, number):
        self.__number = number

    def set_departure(self, departure):
        self.__departure = Airport(self.__config)
        self.__departure.load(departure)

    def set_destination(self, destination):
        self.__departure = Airport(self.__config)
        self.__departure.load(destination)

    def set_time(self, time):
        self.__time = time

    # get for each attribute in flight table
    def get_number(self):
        return self.__number

    def get_departure(self):
        return self.__departure

    def get_destination(self):
        return self.__destination

    def get_time(self):
        return self.__time
    
    # save()
    def save(self):
        # - creates a Connection object (the class we created in file connection.py)
        conn = Connection(self.__config)
        # - check if the flight's flight number exists in the table airline_db.Flight
        sql = "select * from flight where flight_number = %s"
        values = [self.get_number()]
        result = list(conn.run_select(sql, values))
        # if the length of my result list is greater than zero, flight exists in the flight table
        if len(result) > 0:
            # the pilot exists
            # use the appropriate function from Connection to update*** the existing
            #     tuple with the current values for this flight.
            sql = "update flight set flight_number = %s, departure_airport = %s, \
            destination_airport = %s, time = %s \
            where flight_number = %s"
            values = [str(self.get_number()), str(self.get_departure()), str(self.get_destination()), str(self.get_time()),
                      str(self.get_number())]
        else:
            # the flight does NOT exist in the flight table
            sql = "insert into flight(flight_number, departure_airport, destination_airport, time) values (%s, %s, %s, %s)"
            values = [str(self.get_number()), str(self.get_departure()), str(self.get_destination()), str(self.get_time())]
        # call run_change from Connection with the sql and values I created in the if/else statement
        result = conn.run_change(sql, values)
        if result == 1:
            return True
        else:
            return False
    
    # load()
    def load(self, number):
        conn = Connection(self.__config)
        sql = "select * from flight where flight_number = %s"
        values = [str(number)]
        result = conn.run_select(sql, values)
        if len(result) > 0:
            # get the first row from the resulting table
            result = result[0]
            # set the flight attributes with whatever I got from the result[0]
            self.set_number(result[0])
            self.set_departure(result[1])
            self.set_destination(result[2])
            self.set_time(result[3])
            return True
        else:
            return False

    # remove()
    def remove(self):
        conn = Connection(self.__config)
        sql = "delete from flight where flight_number = %s"
        values = [self.get_number()]
        result = conn.run_change(sql, values)
        if result == 1:
            return True
        else:
            return False