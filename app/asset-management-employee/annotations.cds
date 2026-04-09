// using EmployeeService as service from '../../srv/asset-service';
// annotate service.Employee with @(
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
//                 Label : 'email',
//                 Value : email,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'department_ID',
//                 Value : department_ID,
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
//     UI.LineItem : [
//         {
//             $Type : 'UI.DataField',
//             Label : 'ID',
//             Value : ID,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'name',
//             Value : name,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'email',
//             Value : email,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'department_ID',
//             Value : department_ID,
//         },
//     ],
// );

// annotate service.Employee with {
//     department @Common.ValueList : {
//         $Type : 'Common.ValueListType',
//         CollectionPath : 'Department',
//         Parameters : [
//             {
//                 $Type : 'Common.ValueListParameterInOut',
//                 LocalDataProperty : department_ID,
//                 ValueListProperty : 'ID',
//             },
//             {
//                 $Type : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'name',
//             },
//             {
//                 $Type : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'manager_ID',
//             },
//         ],
//     }
// };

using EmployeeService as service from '../../srv/asset-service';

annotate service.Employee with @(
    UI.HeaderInfo: {
        TypeName: 'Employee',
        TypeNamePlural: 'Employees',
        Title: { Value: name },
        Description: { Value: email }
    },
    
    // Define the columns for the main List Report
    UI.LineItem: [
        { Value: ID, Label: 'Employee ID' },
        { Value: name, Label: 'Name' },
        { Value: email, Label: 'Email' },
        { Value: department_ID, Label: 'Department' } // Assuming department is an association
    ],

    // Add search/filter bars at the top
    UI.SelectionFields: [
        name,
        department_ID
    ]
);


annotate service.Employee with @(
    // Define sections on the Object Page
    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#EmployeeDetails',
            Label: 'Employee Information'
        },
        {
            $Type: 'UI.ReferenceFacet',
            Target: 'assets/@UI.LineItem', // Points to the Asset association's LineItem
            Label: 'Assigned Assets'
        }
    ],

    // Group the standard employee fields
    UI.FieldGroup #EmployeeDetails: {
        Data: [
            { Value: ID },
            { Value: name },
            { Value: email },
            { Value: department_ID }
        ]
    }
);

annotate service.Asset with @(
    UI.LineItem: [
        { Value: serialNumber, Label: 'Serial Number' },
        { Value: model.name, Label: 'Model' },
        { Value: employee_ID, Label: 'Assigned Employee' } // Assuming employee is an association
    ]
);

// Define how the nested "Assets" table should look
annotate service.Asset with @(
    UI.HeaderInfo: {
        TypeName: 'Asset',
        TypeNamePlural: 'Assets',
        Title: { Value: serialNumber },
        Description: { Value: model.name } // Shows the Model Name under the Serial Number
    },

    UI.Facets: [
        {
            $Type: 'UI.CollectionFacet',
            ID: 'AssetDetails',
            Label: 'Asset Information',
            Facets: [
                { $Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#General', Label: 'General Info' },
                { $Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#Dates', Label: 'Dates & Warranty' }
            ]
        },
        {
            $Type: 'UI.ReferenceFacet',
            Target: 'history/@UI.LineItem', // This will show the audit trail table
            Label: 'Assignment History'
        }
    ],

    UI.FieldGroup #General: {
        Data: [
            { Value: serialNumber },
            { Value: model.name }
        ]
    },
    UI.FieldGroup #Dates: {
        Data: [
            { Value: assignedAt },
            { Value: returnedAt }
        ]
    }
);

annotate service.AssetHistory with @(
    UI.LineItem: [
        { Value: employee_ID, Label: 'EmployeeID' },
        { Value: employee.name, Label: 'Assigned Employee' }, // Assuming employee is an association
        { Value: assignedAt, Label: 'Created On' },
        { Value: returnedAt, Label: 'Returned On' },
    ]
);