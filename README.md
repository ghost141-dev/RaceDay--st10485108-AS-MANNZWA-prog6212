# RaceDay - Part 1: System Planning and Database

**Module:** PROG6212/w - Programming 2B
**Assessment:** Portfolio of Evidence (POE), Part 1 of 3
**Author:** Amos

## 1. System Description

RaceDay is a full-stack, web-based event management system built for the South
African road running, walking, and cycling community. Many community events are
still run through paper registration, spreadsheets, and disconnected messaging,
which leaves organisers overwhelmed and participants underserved. RaceDay solves
this by giving Event Organisers a single place to create and manage events,
categories, and results, while Participants can browse events, enter them,
track their personal race history, and prepare for race day using route and
event information.

This POE is built progressively across three parts:

- **Part 1 (this submission):** System planning - an Entity Relationship
  Diagram, a full API endpoint plan, and a SQL database script. No application
  code is written in this part.
- **Part 2:** A RESTful API built in ASP.NET Core (C#), connected to the
  database planned here, with role-based authentication and unit tests.
- **Part 3:** An ASP.NET Core MVC web application that consumes the Part 2
  API, integrates Azure Blob Storage for images, and is containerised with
  Docker.

## 2. User Roles

RaceDay supports two distinct roles, planned for and enforced from Part 1
onward:

| Role | Description |
|---|---|
| **Organiser** | Creates, edits, and deletes events; manages event categories; captures participant results after an event; views all enrolments for their events. |
| **Participant** | Creates an account; browses upcoming events; enters an event by selecting a category; views their own enrolments and status; tracks their personal result history (finish time and position) once an Organiser publishes results. |

## 3. What's in the `/docs` Folder

| File | Description |
|---|---|
| `ERD.png` | Entity Relationship Diagram for the full RaceDay data model - 6 entities (Users, Events, Categories, Routes, Enrolments, Results), with primary keys, foreign keys, and cardinality shown for every relationship. |
| `API_Endpoint_Plan.md` | Full endpoint plan covering Authentication, User Profile, Events, Categories, Event Enrolments, and Results. Each row lists the HTTP method, route, description, required role, request body, and expected response(s), including failure codes. |
| `RaceDay_Database.sql` | SQL Server script (written for SSMS) that creates every table from the ERD with primary keys, foreign keys, and constraints, and seeds the database with 2 Organisers, 2 Participants, 3 Events, categories, routes, enrolments, and results. |

The SQL script matches the ERD exactly - every entity in the diagram has a
corresponding `CREATE TABLE` statement with the same keys and relationships.

## 4. How the Pieces Fit Together

- **Users** holds both Organisers and Participants, distinguished by a `Role`
  column, rather than two separate account tables - this keeps
  authentication in Part 2 simple (one login endpoint for both roles).
- **Events** belong to one Organiser (`OrganiserId` foreign key) and can have
  many **Categories** and **Routes**.
- **Enrolments** is the junction that links a Participant, an Event, and the
  Category they chose - this is what lets a Participant "enter an event."
- **Results** has a one-to-one relationship with **Enrolments**: a result can
  only exist once a Participant has enrolled, and only one result can be
  captured per enrolment.

## 5. Running the SQL Script

1. Open SQL Server Management Studio (SSMS) and connect to a local or remote
   SQL Server instance.
2. Open `docs/RaceDay_Database.sql`.
3. Execute the script (F5). It will:
   - Create the `RaceDayDb` database if it does not already exist.
   - Drop and recreate all six tables (safe to re-run during development).
   - Seed the database with sample Organisers, Participants, Events,
     Categories, Routes, Enrolments, and Results.
4. Verify the data with, for example:
   ```sql
   USE RaceDayDb;
   SELECT * FROM dbo.Events;
   SELECT * FROM dbo.Enrolments;
   ```

## 6. GitHub and CI/CD

A GitHub Actions workflow at `.github/workflows/part1-validate-docs.yml` runs
on every push and confirms that the `/docs` folder contains the ERD, the API
endpoint plan, and the SQL script, and that a root-level `README.md` exists.

**CI/CD green build screenshot:**

<img width="1509" height="432" alt="ci work" src="https://github.com/user-attachments/assets/68b94b47-7bec-4cf1-a5ab-ee7381ad673d" />


## 7. Video Walkthrough

**YouTube (unlisted) link:** https://www.youtube.com/@Amosghost

The video walks through:
- The planning documents in `/docs`.
- The ERD design decisions (why each entity and relationship was chosen).
- The API endpoint plan choices (why each endpoint and role restriction was
  chosen).
- A live run of `RaceDay_Database.sql` in SSMS, showing the tables and seed
  data being created.

## 8. AI Disclosure

AI tooling (Claude) was used to assist with planning structure, drafting the
ERD layout, and formatting this documentation. All design decisions,
diagramming, and the final SQL script were reviewed, understood, and adapted
by the author before submission, in line with the POE's academic integrity
requirements.
