from DAO import Pilot, Airport, Flight, Stopover

def main(config_dic):
    while True:
        print("\nOptions:")
        print("1. Manage Pilot")
        print("2. Manage Airport")
        print("3. Manage Flight")
        print("4. Manage Stopover")
        print("5. Create a report")
        print("6. Exit the program")

        choice = input("Enter your choice (1-6): ")
        if choice == '1':
            manage_pilot(config_dic)
        elif choice == '2':
            manage_airport(config_dic)
        elif choice == '3':
            manage_flight(config_dic)
        elif choice == '4':
            manage_stopover(config_dic)
        elif choice == '5':
            create_report(config_dic)
        elif choice == '6':
            print("Exiting the program. Goodbye!")
            break
        else:
            print("Invalid choice. Please enter a number between 1 and 6.")

def manage_pilot(config_dic):
    while True:
        print("\nManaging Pilot:")
        print("1. Insert")
        print("2. Update")
        print("3. Remove")
        print("4. Go back")

        pilot_choice = input("What you want to do next? Enter your choice (1-4): ")
        if pilot_choice == '1':
            # Get user input for new pilot
            id = input("Enter pilot's identification number: ")
            name = input("Enter pilot's name: ")
            salary = input("Enter pilot's salary: ")
            bonus = input("Enter pilot's gratification: ")
            airline = input("Enter pilot's airline: ")
            country = input("Enter pilot's country: ")

            # Create Pilot object
            new_pilot = Pilot(config_dic, id=id, name=name, salary=salary, bonus=bonus, airline=airline, country=country)

            # Save the new pilot
            if new_pilot.save():
                print("Pilot added successfully!")
            else:
                print("Error adding pilot.")

        elif pilot_choice == '2':
            # Handle update operation
            # Get user input for pilot to update
            id_to_update = input("Enter the identification number of the pilot to update: ")

            # Load existing pilot data
            existing_pilot = Pilot(config_dic)
            if existing_pilot.load(id_to_update):
                print(f"Updating Pilot {existing_pilot}:")
        
                # Get user input for updated values
                name = input("Enter new pilot name (or press Enter to keep the existing name): ")
                salary = input("Enter new pilot salary (or press Enter to keep the existing salary): ")
                bonus = input("Enter new pilot gratification (or press Enter to keep the existing gratification): ")
                airline = input("Enter new pilot airline (or press Enter to keep the existing affiliation): ")
                country = input("Enter new pilot country (or press Enter to keep the existing country): ")

                # Update pilot attributes
                if name:
                    existing_pilot.set_name(name)
                if salary:
                    existing_pilot.set_salary(salary)
                if bonus:
                    existing_pilot.set_bonus(bonus)
                if airline:
                    existing_pilot.set_airline(airline)
                if country:
                    existing_pilot.set_country(country)

                # Save the updated pilot
                if existing_pilot.save():
                    print("Pilot updated successfully!")
                else:
                    print("Error updating pilot.")
            else:
                print(f"No pilot found with identification number {id_to_update}.")

        elif pilot_choice == '3':
            # Get user input for pilot to remove
            id_to_remove = input("Enter the identification number of the pilot to remove: ")

            # Load existing pilot data
            existing_pilot = Pilot(config_dic)
            if existing_pilot.load(id_to_remove):
                # Remove the pilot
                if existing_pilot.remove():
                    print("Pilot removed successfully!")
                else:
                    print("Error removing pilot.")
            else:
                print(f"No pilot found with identification number {id_to_remove}.")

        elif pilot_choice == '4':
            break
        else:
            print("Invalid choice. Please enter a number between 1 and 4.")

def manage_airport(config_dic):
    a = Airport
    while True:
        print("\nManaging Airport:")
        print("1. Insert")
        print("2. Update")
        print("3. Remove")
        print("4. Go back")

        airport_choice = input("What you want to do next? Enter your choice (1-4): ")
        if airport_choice == '1':
            # Get user input for new airport
            acronym = input("Enter airport's acronym: ")
            name = input("Enter airport's name: ")
            city = input("Enter airport's city: ")
            country = input("Enter airport's country: ")

            # Create airport object
            new_airport = Airport(config_dic, acronym=acronym, name=name, city=city, country=country)

            # Save the new airport
            if new_airport.save():
                print("Airport added successfully!")
            else:
                print("Error adding airport.")

        elif airport_choice == '2':
            # Handle update operation
            # Get user input for airport to update
            acronym_to_update = input("Enter the acronym of the airport to update: ")

            # Load existing airport data
            existing_airport = Airport(config_dic)
            if existing_airport.load(acronym_to_update):
                print(f"Updating Airport {existing_airport}:")
        
                # Get user input for updated values
                name = input("Enter new airport name (or press Enter to keep the existing salary): ")
                city = input("Enter new city (or press Enter to keep the existing gratification): ")
                country = input("Enter new country (or press Enter to keep the existing country): ")

                # Update pilot attributes
                if name:
                    existing_airport.set_name(name)
                if city:
                    existing_airport.set_city(city)
                if country:
                    existing_airport.set_country(country)

                # Save the updated ariport
                if existing_airport.save():
                    print("airport updated successfully!")
                else:
                    print("Error updating airport.")
            else:
                print(f"No airport found with acronym {acronym_to_update}.")

        elif airport_choice == '3':
            # Get user input for airport to remove
            acronym_to_remove = input("Enter the acronym of the airport to remove: ")

            # Load existing airport data
            existing_airport = Airport(config_dic)
            if existing_airport.load(acronym_to_remove):
                # Remove the airport
                if existing_airport.remove():
                    print("Airport removed successfully!")
                else:
                    print("Error removing airport.")
            else:
                print(f"No airport found with acronym {acronym_to_remove}.")
                
        elif airport_choice == '4':
            break
        else:
            print("Invalid choice. Please enter a number between 1 and 4.")

def manage_flight(config_dic):
    while True:
        print("\nManaging Flight:")
        print("1. Insert")
        print("2. Update")
        print("3. Remove")
        print("4. Go back")

        flight_choice = input("What you want to do next? Enter your choice (1-4): ")
        if flight_choice == '1':
            # Get user input for new flight
            number = input("Enter flight's number: ")
            departure = input("Enter flight's departure airport: ")
            destination = input("Enter flight's destination airport: ")
            time = input("Enter flight's time: ")

            # Create flight object
            new_flight = Flight(config_dic, number=number, departure=departure, destination=destination, time=time)

            # Save the new flight
            if new_flight.save():
                print("flight added successfully!")
            else:
                print("Error adding flight.")

        elif flight_choice == '2':
            # Handle update operation
            # Get user input for flight to update
            number_to_update = input("Enter the number of the flight to update: ")

            # Load existing flight data
            existing_flight = Flight(config_dic)
            if existing_flight.load(number_to_update):
                print(f"Updating flight {existing_flight}:")
        
                # Get user input for updated values
                departure = input("Enter new departure airport (or press Enter to keep the existing salary): ")
                destination = input("Enter new destination airport (or press Enter to keep the existing gratification): ")
                time = input("Enter new time (or press Enter to keep the existing country): ")

                # Update pilot attributes
                if departure:
                    existing_flight.set_departure(departure)
                if destination:
                    existing_flight.set_destination(destination)
                if time:
                    existing_flight.set_time(time)

                # Save the updated ariport
                if existing_flight.save():
                    print("flight updated successfully!")
                else:
                    print("Error updating flight.")
            else:
                print(f"No flight found with acronym {number_to_update}.")

        elif flight_choice == '3':
            # Get user input for flight to remove
            number_to_remove = input("Enter the number of the flight to remove: ")

            # Load existing flight data
            existing_flight = Flight(config_dic)
            if existing_flight.load(number_to_remove):
                # Remove the flight
                if existing_flight.remove():
                    print("flight removed successfully!")
                else:
                    print("Error removing flight.")
            else:
                print(f"No flight found with acronym {number_to_remove}.")
                
        elif flight_choice == '4':
            break
        else:
            print("Invalid choice. Please enter a number between 1 and 4.")

def manage_stopover(config_dic):
    while True:
        print("\nManaging stopover:")
        print("1. Insert")
        print("2. Update")
        print("3. Remove")
        print("4. Go back")

        stopover_choice = input("What you want to do next? Enter your choice (1-4): ")
        if stopover_choice == '1':
            # Get user input for new stopover
            number = input("Enter stopover's number: ")
            date = input("Enter stopover's date: ")
            id = input("Enter stopover's id: ")
            aircraft = input("Enter stopover's aircraft: ")

            # Create stopover object
            new_stopover = Stopover(config_dic, number=number, date=date, id=id, aircraft=aircraft)

            # Save the new stopover
            if new_stopover.save():
                print("stopover added successfully!")
            else:
                print("Error adding stopover.")

        elif stopover_choice == '2':
            # Handle update operation
            # Get user input for stopover to update
            number_to_update = input("Enter the number of the stopover to update: ")

            # Load existing stopover data
            existing_stopover = Stopover(config_dic)
            if existing_stopover.load(number_to_update):
                print(f"Updating stopover {existing_stopover}:")
        
                # Get user input for updated values
                date = input("Enter new date (or press Enter to keep the existing salary): ")
                id = input("Enter new pilot id (or press Enter to keep the existing gratification): ")
                aircraft = input("Enter new aircraft (or press Enter to keep the existing country): ")

                # Update pilot attributes
                if date:
                    existing_stopover.set_date(date)
                if id:
                    existing_stopover.set_id(id)
                if aircraft:
                    existing_stopover.set_aircraft(aircraft)

                # Save the updated ariport
                if existing_stopover.save():
                    print("stopover updated successfully!")
                else:
                    print("Error updating stopover.")
            else:
                print(f"No stopover found with acronym {number_to_update}.")

        elif stopover_choice == '3':
            # Get user input for stopover to remove
            number_to_remove = input("Enter the number of the stopover to remove: ")

            # Load existing stopover data
            existing_stopover = Stopover(config_dic)
            if existing_stopover.load(number_to_remove):
                # Remove the stopover
                if existing_stopover.remove():
                    print("stopover removed successfully!")
                else:
                    print("Error removing stopover.")
            else:
                print(f"No stopover found with acronym {number_to_remove}.")
                
        elif stopover_choice == '4':
            break
        else:
            print("Invalid choice. Please enter a number between 1 and 4.")

def create_report(database_config):
    while True:
        print("Create a report:")
        print("1. Number of flights per airline")
        print("2. International Flights per pilots")
        print("3. Pilot's expenses")
        print("4. Go back")

        choice = input("Enter your choice (1-4): ")

        if choice == "1":
            pass
        elif choice == "2":
            pass
        elif choice == "3":
            pass
        elif choice == "4":
            break
        else:
            print("Invalid choice. Please enter a number between 1 and 4.")

if __name__ == "__main__":
    # Assuming you have a database configuration dictionary
    config_dic = {...}  # Replace with your actual database configuration

    main(config_dic)
