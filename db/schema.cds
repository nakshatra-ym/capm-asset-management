namespace asset.management;

entity Employees {
  key ID : UUID;
  name   : String;
  email  : String;
  department : String;
}

entity Assets {
  key ID : UUID;
  name   : String;
  type   : String;
  serialNumber : String;
  status : String;
  employee : Association to Employees;
}