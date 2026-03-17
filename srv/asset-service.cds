using { asset.management as db } from '../db/schema';

service AssetService {


  @UI.LineItem: [
    { Value: name },
    { Value: email },
    { Value: department }
  ]
  entity Employees as projection on db.Employees;
   @UI.LineItem: [
    { Value: name },
    { Value: type },
    { Value: status },
    { Value: employee.name },
     {
      $Type  : 'UI.DataFieldForAction',
      Action : 'AssetService.assignAsset',
      Label  : 'Assign Asset'
    }
  ]
  @odata.draft.enabled
  entity Assets as projection on db.Assets
  actions {
      @(
        Core.OperationAvailable: ($self.status != 'Assigned')
      )
      @Common.SideEffects: {
        TargetProperties: ['status', 'employee_ID','name']
      }
      @requires: 'Admin'
      action assignAsset(
        @(
         Common        : {
                ValueListWithFixedValues : true,
                ValueList : {
                    Label          : 'Employees',
                    CollectionPath : 'Employees',
                    Parameters     : [
                      {
                        $Type             : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'ID',
                        LocalDataProperty : employeeID
                      },
                      {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'name'
                      },
                      {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'department'
                      }
                    ]
                }
            }
      )
        employeeID : Integer
      );
  };

}