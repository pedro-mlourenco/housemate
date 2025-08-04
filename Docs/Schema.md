| Users      |              |
| ---------- | ------------ |
| `Id`       | **Pk**       |
| `Name`     | varchar(150) |
| `Password` | varchar(32)  |

| HouseHold       |              |
| --------------- | ------------ |
| `Id`            | **Pk**       |
| `Name`          | varchar(50)  |
| `Description`   | varchar(255) |
| **`CreatedBy`** | **Fk**       |

| HouseHoldMembers  |        |
| ----------------- | ------ |
| `Role`            | Enum() |
| **`UserId`**      | **PK** |
| **`HouseHoldId`** | **PK** |

| Profiles         |              |
| ---------------- | ------------ |
| `Id`             | **Pk**       |
| `Name`           | varchar(150) |
| `PhoneNumber`    | varchar(32)  |
| `CountryPhoneId` | varchar(32)  |
| `Street`         | varchar(32)  |
| `Door`           | varchar(32)  |
| `Floor`          | varchar(32)  |
| `City`           | varchar(32)  |
| `Street`         | varchar(32)  |
| `PostCode`       | varchar(32)  |
| `Country`        | varchar(32)  |
| **`UserId`**     | **Fk**       |

| Events         |              |
| -------------- | ------------ |
| `Id`           | **Pk**       |
| `Name`         | varchar(150) |
| `Description`  | varchar(255) |
| `DateTime`     | DateTime     |
| `Participants` | JSON         |
| **`UserId`**   | **Fk**       |
