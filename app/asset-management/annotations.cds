// using AssetService as service from '../../srv/asset-service';
// annotate service.Assets with @(
//     UI.FieldGroup #GeneratedGroup : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'ID',
//                 Value : ID,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'name',
//                 Value : name,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'type',
//                 Value : type,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'serialNumber',
//                 Value : serialNumber,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'status',
//                 Value : status,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'employee_ID',
//                 Value : employee_ID,
//             },
//         ],
//     },
//     UI.Facets : [
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'GeneratedFacet1',
//             Label : 'General Information',
//             Target : '@UI.FieldGroup#GeneratedGroup',
//         },
//     ],
// );

// annotate service.Assets with {
//     employee @Common.ValueList : {
//         $Type : 'Common.ValueListType',
//         CollectionPath : 'Employees',
//         Parameters : [
//             {
//                 $Type : 'Common.ValueListParameterInOut',
//                 LocalDataProperty : employee_ID,
//                 ValueListProperty : 'ID',
//             },
//             {
//                 $Type : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'name',
//             },
//             {
//                 $Type : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'email',
//             },
//             {
//                 $Type : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'department',
//             },
//         ],
//     }
// };

