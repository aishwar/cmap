Readme
======

Parses a file of the format

    Person:Aishwar
      Address:Home
        City:Toronto
        Area:Scarborough
      Address:Work
        City:Toronto
        Area:North York

to a Javascript map:

    {
      Person: {
        name:"Aishwar",
        Address: [
          {
            name:Home,
            City: {
              name: Toronto
            },
            Area: {
              name:Scaborough
            }
          },
          {
            name:Work,
            City: {
              name:Toronto
            },
            Area: {
              name:North York
            }
          }
        ]
      }
    }

Other Parse-able examples:
--------------------------
  
    Person
      name:Aishwar
      Address:Home
      Address:Work
  

