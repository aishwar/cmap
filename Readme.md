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
          City:Toronto,
          Area:Scaborough
        },
        {
          name:Work,
          City:Toronto,
          Area:North York
        }
      ]
    }
  }

Other Parse-able examples:
  
  Person
    name:Aishwar
    Address:Home
    Address:Work
  

