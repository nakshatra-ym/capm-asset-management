namespace asset.management;
using { managed } from '@sap/cds/common';

entity Employees : managed {
  key ID : Integer;
  name   : String;
  email  : String;
  department : String;
}

entity Assets : managed {
  key ID : Integer;
  name   : String;
  type   : String;
  serialNumber : String;
  status : String;
  employee : Association to Employees;
}