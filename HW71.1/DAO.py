#
# Homework 7: Python + MySQL connection
# Student: Jared Brotamonte, (6072572)
#

# TODO 1 (2 points). Import your Connection class
from connection import Connection

#
# INSTRUCTIONS: The Pilot class is created for you. The __init__ function
#               initializes the class properties and there are get_ and set_
#               functions for each of the properties. Your job is to complete
#               the class with the methods to save and load data to/from the
#               database based on the primary key (pilot.identification)
#

# define the class pilot
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

    # TODO 2. Create the function save()
    #     # Process: create a Connection object (the class we created in file
    #     #               connection_solution.py) by calling its constructor
    #     #               and passing the config dictionary as argument
    #     #          check if the pilot's identification number exists in the Pilot
    #     #               table
    #     #          if the identification number does NOT exist, insert the pilot as
    #     #               a new tuple in the Pilot table
    #     #          otherwise, update the existing tuple with the current values for
    #     #               this Pilot
    #     #          Note: always insert/update all the Pilot's attributes, as we are
    #     #                not keeping track of which ones changed
    #     # Parameters: self
    #     # Return: True if the execution of the SQL statement successfully affected
    #     #               one row in the Pilot table (one pilot inserted or updated)
    #     #         False, otherwise
    # # Grading: function header (2 points); process (21 points)
    def save(self):
        # Create a Connection object
        conn = Connection(self.__config)

        # Check if the pilot's identification number exists in the Pilot table
        sql = "SELECT * FROM Pilot WHERE identification = %s"
        values = (self.__id,)
        existing_pilot = conn.run_select(sql, values)

        if not existing_pilot:
            # Pilot does not exist, insert a new tuple
            sql = "INSERT INTO Pilot (identification, pilot_name, salary, gratification, airline_name, country) VALUES (%s, %s, %s, %s, %s, %s)"
            values = (self.__id, self.__name, self.__salary, self.__bonus, self.__airline, self.__country,)
            result = conn.run_change(sql, values)
        else:
          # Pilot exists, update the existing tuple
            sql = "UPDATE Pilot SET pilot_name=%s, salary=%s, gratification=%s, airline_name=%s, country=%s WHERE identification=%s"
            values = (self.__name, self.__salary, self.__bonus, self.__airline, self.__country, self.__id,)
            result = conn.run_change(sql, values)

        if result > 0:
            return True
        else:
            return False

    # TODO 3. Create the function remove()
    #     # Process: create a Connection object (the class we created in file
    #     #               connection_solution.py) by calling its constructor
    #     #               and passing the config dictionary as argument
    #     #          delete the pilot based on the pilot's identification number
    #     # Parameters: self
    #     # Return: True if the execution of the SQL statement successfully affected
    #     #               one row in the Pilot table (one pilot removed)
    #     #         False, otherwise
    # Grading: function header (2 points); process (6 points)
    def remove(self):
        # create connection object
        conn = Connection(self.__config)

        # delete pilot based on pilot id
        sql = "DELETE FROM Pilot WHERE identification = %s"
        values = (self.__id,)
        result = conn.run_change(sql, values)

        # return based on if it worked or not
        if result > 0:
            return True
        else:
            return False


    # TODO 4. Create the function load()
    #     # Process: create a Connection object (the class we created in file
    #     #               connection_solution.py) by calling its constructor and
    #     #               passing the config dictionary as argument
    #     #          find an existing pilot based on the pilot's identification
    #     #               number provided as argument
    #     #          if the returned result set contains an existing Pilot tuple, set
    #     #               the attributes of the pilot object to the values in the
    #     #               result set
    #     # Parameters: self
    #     #             id: integer value that represents the pilot's identification
    #     #                   number
    #     # Return: True if the pilot is successfully loaded with values retrieved
    #     #               from the Pilot table
    #     #         False otherwise
    # Grading: function header (2 points); process (15 points)
    def load(self, id):
        # Create a Connection object
        conn = Connection(self.__config)

        # Find an existing pilot based on the identification number
        sql = "SELECT * FROM Pilot WHERE identification = %s"
        values = (self.__id,)
        result = conn.run_select(sql, values)

        if result:
            # Pilot found, set the attributes of the pilot object
            self.__id, self.__name, self.__salary, self.__bonus, self.__airline, self.__country = result[0]
            return True  # Successfully loaded
        else:
            return False  # Pilot not found
