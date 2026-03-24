using {asset.management as db} from '../db/schema';

service AssetService {

  @UI.Facets        : [{
    $Type : 'UI.ReferenceFacet',
    Label : 'Assets',
    Target: 'assets/@UI.LineItem'
  }]
  @UI.LineItem      : [
    {Value: name},
    {Value: email},
    {Value: department},
    {
      $Type : 'UI.DataFieldForAction',
      Action: 'AssetService.assignAsset',
      Label : 'Assign Asset'
    }
  ]
  @UI.Identification: [{
    $Type : 'UI.DataFieldForAction',
    Action: 'AssetService.assignAsset',
    Label : 'Assign Asset'
  }]
  entity Employees as projection on db.Employees
    actions {
            // @(
            //   Core.OperationAvailable: ($self.status != 'Assigned')
            // )
      @Common.SideEffects: {TargetProperties: ['assets']}
      //       // @requires: 'Admin'
      action assignAsset(
                         @(Common: {
                           ValueListWithFixedValues: true,
                           ValueList               : {
                             Label         : 'Assets',
                             CollectionPath: 'Assets',
                             Parameters    : [
                               {
                                 $Type            : 'Common.ValueListParameterInOut',
                                 ValueListProperty: 'ID',
                                 LocalDataProperty: assetID
                               },
                               {
                                 $Type            : 'Common.ValueListParameterDisplayOnly',
                                 ValueListProperty: 'name'
                               },
                               {
                                 $Type            : 'Common.ValueListParameterDisplayOnly',
                                 ValueListProperty: 'type'
                               },
                               {
                                 $Type            : 'Common.ValueListParameterConstant',
                                 ValueListProperty: 'status',
                                 Constant         : 'Available'
                               }
                             ]
                           }
                         })
                         assetID: Integer);
    }


  @UI.LineItem: [
    {Value: name},
    {Value: type},
    {Value: status},
    {
      $Type : 'UI.DataFieldForAction',
      Action: 'AssetService.unassignAsset',
      Label : 'Unassign Asset'
    }
  ]
  @odata.draft.enabled
  entity Assets    as projection on db.Assets
    actions {
      @Common.SideEffects: {TargetProperties: ['employee']}
      action unassignAsset()
    }


}
