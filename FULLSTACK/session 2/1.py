from enum import Enum


class BillItemType(Enum):
    BASE_CHARGE, ADDITIONAL_SERVICE, FINE, OTHER = 1, 2, 3, 4


class VehicleLogType(Enum):
    ACCIDENT, FUELING, CLEANING_SERVICE, OIL_CHANGE, REPAIR, OTHER = 1, 2, 3, 4, 5, 6


class VanType(Enum):
    PASSENGER, CARGO = 1, 2


class CarType(Enum):
    ECONOMY, COMPACT, INTERMEDIATE, STANDARD, FULL_SIZE, PREMIUM, LUXURY = 1, 2, 3, 4, 5, 6, 7


class VehicleStatus(Enum):
    AVAILABLE, RESERVED, LOANED, LOST, BEING_SERVICED, OTHER = 1, 2, 3, 4, 5, 6


class ReservationStatus(Enum):
    ACTIVE, PENDING, CONFIRMED, COMPLETED, CANCELLED, NONE = 1, 2, 3, 4, 5, 6


class AccountStatus(Enum):
    ACTIVE, CLOSED, CANCELED, BLACKLISTED, BLOCKED = 1, 2, 3, 4, 5


class PaymentStatus(Enum):
    UNPAID, PENDING, COMPLETED, FILLED, DECLINED, CANCELLED, ABANDONED, SETTLING, SETTLED, REFUNDED = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10


class Address:
    def __init__(self, street, city, state, zip_code, country):
        self.__street_address = street
        self.__city = city
        self.__state = state
        self.__zip_code = zip_code
        self.__country = country


class Person():
    def __init__(self, name, address, email, phone):
        self.__name = name
        self.__address = address
        self.__email = email
        self.__phone = phone



from abc import ABC
from .constants import AccountStatus


# For simplicity, we are not defining getter and setter functions. The reader can
# assume that all class attributes are private and accessed through their respective
# public getter methods and modified only through their public methods function.


class Account(ABC):
    def __init__(self, id, password, person, status=AccountStatus.NONE):
        self.__id = id
        self.__password = password
        self.__status = AccountStatus.NONE
        self.__person = person

    def reset_password(self):
        None


class Member(Account):
    def __init__(self):
        self.__total_vehicles_reserved = 0

    def get_reservations(self):
        None


class Receptionist(Account):
    def __init__(self, date_joined):
        self.__date_joined = date_joined

    def search_member(self, name):
        None


class AdditionalDriver:
    def __init__(self, id, person):
        self.__driver_id = id
        self.__person = person


class CarRentalLocation:
    def __init__(self, name, address):
        self.__name = name
        self.__location = address

    def get_location(self):
        return self.__location


class CarRentalSystem:
    def __init__(self, name):
        self.__name = name
        self.__locations = []

    def add_new_location(self, location):
        None


from abc import ABC
from datetime import datetime
from .constants import ReservationStatus


class Vehicle(ABC):
    def __init__(self, license_num, stock_num, capacity, barcode, has_sunroof, status, model, make, manufacturing_year,
                 mileage):
        self.__license_number = license_num
        self.__stock_number = stock_num
        self.__passenger_capacity = capacity
        self.__barcode = barcode
        self.__has_sunroof = has_sunroof
        self.__status = status
        self.__model = model
        self.__make = make
        self.__manufacturing_year = manufacturing_year
        self.__mileage = mileage
        self.__log = []

    def reserve_vehicle(self):
        None

    def return_vehicle(self):
        None


class Car(Vehicle):
    def __init__(self, license_num, stock_num, capacity, barcode, has_sunroof, status, model, make, manufacturing_year,
                 mileage, type):
        super().__init__(license_num, stock_num, capacity, barcode,
                         has_sunroof, status, model, make, manufacturing_year, mileage)
        self.__type = type


class Van(Vehicle):
    def __init__(self, license_num, stock_num, capacity, barcode, has_sunroof, status, model, make, manufacturing_year,
                 mileage, type):
        super().__init__(license_num, stock_num, capacity, barcode,
                         has_sunroof, status, model, make, manufacturing_year, mileage)
        self.__type = type


class Truck(Vehicle):
    def __init__(self, license_num, stock_num, capacity, barcode, has_sunroof, status, model, make, manufacturing_year,
                 mileage, type):
        super().__init__(license_num, stock_num, capacity, barcode,
                         has_sunroof, status, model, make, manufacturing_year, mileage)
        self.__type = type


# We can have similar definition for other vehicle types

# ...

class VehicleLog:
    def __init__(self, id, type, description, creation_date):
        self.__id = id
        self.__type = type
        self.__description = description
        self.__creation_date = creation_date

    def update(self):
        None

    def search_by_log_type(self, type):
        None


class VehicleReservation:
    def __init__(self, reservation_number):
        self.__reservation_number = reservation_number
        self.__creation_date = datetime.date.today()
        self.__status = ReservationStatus.ACTIVE
        self.__due_date = datetime.date.today()
        self.__return_date = datetime.date.today()
        self.__pickup_location_name = ""
        self.__return_location_name = ""

        self.__customer_id = 0
        self.__vehicle = None
        self.__bill = None
        self.__additional_drivers = []
        self.__notifications = []
        self.__insurances = []
        self.__equipments = []
        self.__services = []

    def fetch_reservation_details(self, reservation_number):
        None

    def get_additional_drivers(self):
        return self.__additional_drivers

def main():
    # Create a car rental system
    rental_system = CarRentalSystem("MyRentalSystem")

    # Create rental locations
    location1 = CarRentalLocation("Location 1", Address("123 Street", "City", "State", "12345", "Country"))
    location2 = CarRentalLocation("Location 2", Address("456 Avenue", "City", "State", "67890", "Country"))

    # Add rental locations to the system
    rental_system.add_new_location(location1)
    rental_system.add_new_location(location2)

    # Create a member
    member = Member("member_id", "password", Person("John Doe", Address("789 Road", "City", "State", "54321", "Country"),
                                                    "john@example.com", "123456789"))

    # Create a receptionist
    receptionist = Receptionist("receptionist_id", "password", Person("Alice Smith", Address("101 Main St", "City",
                                                                                             "State", "98765",
                                                                                             "Country"),
                                                                      "alice@example.com", "987654321"),
                                date_joined="2024-05-31")

    # Search for a member
    receptionist.search_member("John Doe")

    # Create a vehicle reservation
    reservation = VehicleReservation(reservation_number="123456")

    # Reserve a vehicle
    reservation.reserve_vehicle()

    # Return a vehicle
    reservation.return_vehicle()

    # Get additional drivers
    additional_drivers = reservation.get_additional_drivers()

    # Search for vehicles by type
    inventory = VehicleInventory()
    compact_cars = inventory.search_by_type("Compact")

    # Search for vehicles by model
    specific_model = inventory.search_by_model("Toyota Camry")


if __name__ == "__main__":
    main()
