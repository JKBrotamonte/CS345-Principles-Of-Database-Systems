#
# Homework 7: Python + MySQL connection
# Student: Jared Brotamonte, (6072572)
#

# TODO 1 (1 point). Import the Mysql connector
import mysql.connector

# TODO 2 (1 point). Define a new class called Connection.
class Connection:

# TODO 3. Create the __init__ function, that initialize a set of properties for
#     # the Connection function
#     #   Important: we make the properties private by using self.__ prefix for
#     #       each of the variables
#     # Process: set the property self.__config to the argument config_dic
#     #          set the property self.__mydb to None
#     #          set the property self.__cursor to None
#     # Parameters: self
#     #             config_dic: a dictionary that contains the connection details
#     # Return: None
# # Grading: function header (1 point); process (4.5 points)
    def __init__(self, config_dic):
        self.__config = config_dic
        self.__mydb = None
        self.__cursor = None

# TODO 4. Create the function open_conn()
#     # Process: open a connection by calling the MySQL connector
#     #          constructor and store the connection into the self.__mydb
#     #          use self.__mydb to open a cursor and store in self.__cursor
#     # Parameters: self
#     # Return: None
# # Grading: function header (1 point); process (4.5 points)
    def open_conn(self):
        self.__mydb = mysql.connector.Connect(**self.__config)
        self.__cursor = self.__mydb.cursor(buffered=True)

# TODO 5. Create the function get_cursor()
#     # Process: return the cursor variable
#     # Parameters: self
#     # Return: self.__cursor
# # Grading: function header (1 point); process (1.5 point)
    def get_cursor(self):
        return self.__cursor

# TODO 6. Create the function commit_changes()
#     # Process: check if a connection is open
#     #          if so, commit the changes
#     #          otherwise raise a RuntimeError exception with the message
#     #               "MySQL connection is not open."
#     # Parameters: self
#     # Return: None
# # Grading: function header (1 point); process (4.5 points)
    def commit_changes(self):
        if self.__mydb.is_connected():
            self.__mydb.commit()

        else:
            print("MySQL connection is not open.")

# TODO 7. Create the function close_conn()
#     # Process: close the cursor
#     #          set the cursor variable to None
#     #          close the connection
#     #          set the connection variable to None
#     # Parameters: self
#     # Return: None
# # Grading: function header (1 point); process (6 points)
    def close_conn(self):
        self.__cursor.close()
        self.__mydb.close()

# TODO 8. Create the function run_select()
#     # Description: this function executes SQL commands that return a result set
#     # Process: open a connection
#     #          obtain a cursor from the connection
#     #          execute the sql with the values provided as arguments
#     #          fetch the result set into a list
#     #          close the connection
#     #          return the resulting list
#     # Parameters: self
#     #             sql - string that corresponds to the SQL command to be
#     #                   executed
#     #             values - tuple with the values to be used when the sql has %s
#     #                      for input values (default=None)
#     # Return: list of tuples fetched from the cursor
# # Grading: function header (1 point); process (9 points)
    def run_select(self, sql, values):
        # open a connection
        self.open_conn()

        # get cursor
        cursor = self.get_cursor()

        # execute the sql with values as arguements
        cursor.execute(sql, values)

        # fetch results set into a list
        sql_list = cursor.fetchall()

        # close connection
        self.close_conn()

        # return reulting list
        return sql_list

# TODO 9. Create the function run_change()
#     # Description: this function executes SQL commands that must be committed
#     #              (i.e., insert, update, delete)
#     # Process: open a connection
#     #          obtain a cursor from the connection
#     #          execute the sql with the values provided as arguments
#     #          commit the changes
#     #          store the number of affected rows into a variable
#     #          close the connection
#     #          return the number of affected rows
#     # Parameters: self
#     #             sql - string that corresponds to the SQL command to be
#     #                   executed
#     #             values - tuple with the values to be used when the sql has %s
#     #                      for input values (default=None)
#     # Return: the number of rows affected by the SQL command
# # Grading: function header (1 points); process (11 points)
    def run_change(self, sql, values):
        # open a connection
        self.open_conn()

        # obtain cursor
        cursor = self.get_cursor()

        # execute sql with values as arguments
        cursor.execute(sql, values)

        # commit changes
        self.commit_changes()

        # store num of affected rows into variable
        num_rows = cursor.rowcount

        # close connection
        self.close_conn()

        # return num of affected rows
        return num_rows