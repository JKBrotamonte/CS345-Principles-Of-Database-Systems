# import class Pilot from DAO.py file
from DAO import Pilot


# main function
def main(config_dic):
    # creates a Pilot object
    p = Pilot(config_dic)
    # print a message
    print("Trying to load the Pilot with identification = 104")
    # load the pilot with id 104, if exists
    output = p.load(104)
    # test if the output returned True (pilot exists)
    if output:
        # print the pilot
        print(p)
    # otherwise
    else:
        # inform that pilot doesn't exist
        print("Pilot doesn't exist.\n")

    # populate Pilot object with identification = 104
    p.set_id(104)
    p.set_name('Peter Parker')
    p.set_country('Brazil')
    p.set_salary(30000)
    p.set_bonus(500)
    p.set_airline('Azul')

    # save the Pilot object to the database
    output = p.save()
    # test if the output returned True (pilot successfully saved)
    if output:
        # print the pilot
        print("New pilot: (" + str(p.get_id()), p.get_name() + ")")
    # otherwise
    else:
        # inform the user that something went wrong (pilot not saved)
        print("Something went wrong, please try again!")

    # change the Pilot object
    p.set_name('New Name')
    # persist the changes into the database
    p.save()
    # test if the output returned True (pilot successfully updated)
    if output:
        # print the pilot
        print("Pilot changed: (" + str(p.get_id()), p.get_name() + ")")
    # otherwise
    else:
        # inform the user that something went wrong (pilot not updated)
        print("Something went wrong, please try again!")

    # remove the Pilot object from the database
    p.remove()
    # test if the output returned True (pilot successfully removed)
    if output:
        # print the pilot
        print("Pilot removed: (" + str(p.get_id()), p.get_name() + ")")
    # otherwise
    else:
        # inform the user that something went wrong (pilot not removed)
        print("Something went wrong, please try again!")


if __name__ == '__main__':
    #  import the config module
    import config

    #
    # Configure MySQL login and database to use in config.py
    # This line returns a dictionary containing MySQL credentials and
    # database information
    # copy() is used to ensure a shallow copy of the dictionary and avoid
    # unintentional modifications to the original connection details
    config_dic = config.Config.dbinfo().copy()
    # calls the main function passing the config dictionary
    main(config_dic)
