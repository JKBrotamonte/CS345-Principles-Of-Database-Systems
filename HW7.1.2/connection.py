######
# Homework 8: Python + MySQL connection
# Solution file
# Ana Paula Chaves, CS 345
######

# 1. Import the Mysql connector
import mysql.connector


# 2. Define a new class called Connection
class Connection:

    # 3. Create the __init__ function, that initialize a set of properties for
    # the Connection function
    #   Important: we make the properties private by using self.__ prefix for
    #       each of the variables
    # Process: set the property self.__config to the argument config_dic
    #          set the property self.__mydb to None
    #          set the property self.__cursor to None
    # Parameters: self
    #             config_dic: a dictionary that contains the connection details
    # Return: None
    def __init__(self, config_dic):
        self.__mydb = None
        self.__cursor = None
        self.__config = config_dic

    # 4. Create the function open_conn()
    # Process: open a connection by calling the MySQL connector
    #          constructor and store the connection into the self.__mydb
    #          use self.__mydb to open a cursor and store in self.__cursor
    # Parameters: self
    # Return: None
    def open_conn(self):
        self.__mydb = mysql.connector.connect(
            **self.__config)
        self.__cursor = self.__mydb.cursor()

    # 5. Create the function get_cursor()
    # Process: return the cursor variable
    # Parameters: self
    # Return: self.__cursor
    def get_cursor(self):
        return self.__cursor

    # 6. Create the function commit_changes()
    # Process: check if a connection is open
    #          if so, commit the changes
    #          otherwise raise a RuntimeError exception with the message
    #               "MySQL connection is not open."
    # Parameters: self
    # Return: None
    def commit_changes(self):
        if self.__mydb.is_connected():
            self.__mydb.commit()
        else:
            raise RuntimeError("MySQL connection is not open.")

    # 7. Create the function close_conn()
    # Process: close the cursor
    #          set the cursor variable to None
    #          close the connection
    #          set the connection variable to None
    # Parameters: self
    # Return: None
    def close_conn(self):
        self.__cursor.close()
        self.__cursor = None
        self.__mydb.close()
        self.__mydb = None

    # 8. Create the function run_select()
    # Description: this function executes SQL commands that return a result set
    # Process: open a connection
    #          obtain a cursor from the connection
    #          execute the sql with the values provided as arguments
    #          fetch the result set into a list
    #          close the connection
    #          return the resulting list
    # Parameters: self
    #             sql - string that corresponds to the SQL command to be
    #                   executed
    #             values - tuple with the values to be used when the sql has %s
    #                      for input values (default=None)
    # Return: list of tuples fetched from the cursor
    def run_select(self, sql, values=None):
        # open a connection (by calling the appropriate function)
        self.open_conn()
        # obtain a cursor from the connection
        query = self.get_cursor()
        # execute the sql with the values provided as parameters
        query.execute(sql, values)
        # fetch the results into a list variable
        result = query.fetchall()
        # close the connection
        self.close_conn()
        # return the resulting list
        return result

    # 9. Create the function run_change()
    # Description: this function executes SQL commands that must be committed
    #              (i.e., insert, update, delete)
    # Process: open a connection
    #          obtain a cursor from the connection
    #          execute the sql with the values provided as arguments
    #          commit the changes
    #          store the number of affected rows into a variable
    #          close the connection
    #          return the number of affected rows
    # Parameters: self
    #             sql - string that corresponds to the SQL command to be
    #                   executed
    #             values - tuple with the values to be used when the sql has %s
    #                      for input values (default=None)
    # Return: the number of rows affected by the SQL command
    def run_change(self, sql, values=None):
        # opens a connection (by calling the appropriate function)
        self.open_conn()
        # obtain a cursor from the connection
        query = self.get_cursor()
        # executes the sql with the values provided as arguments
        query.execute(sql, values)
        # commits the changes
        self.commit_changes()
        # stores the number of affected rows into a result variable
        result = query.rowcount
        # close the connection
        self.close_conn()
        # return the result
        return result
