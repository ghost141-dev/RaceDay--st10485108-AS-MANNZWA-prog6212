Table Users {
  UserId INT [pk, increment]
  FullName NVARCHAR(150) [not null]
  Email NVARCHAR(150) [not null, unique]
  PasswordHash NVARCHAR(255) [not null]
  Role NVARCHAR(20) [not null, note: 'CHECK: Organiser, Participant']
  PhoneNumber NVARCHAR(20)
  ProfilePictureUrl NVARCHAR(500)
  CreatedAt DATETIME [not null, default: `GETDATE()`]
}

Table Events {
  EventId INT [pk, increment]
  OrganiserId INT [not null]
  Name NVARCHAR(150) [not null]
  Description NVARCHAR(1000)
  EventDate DATETIME [not null]
  Location NVARCHAR(200) [not null]
  DistanceKm DECIMAL(6,2) [not null]
  EventType NVARCHAR(20) [not null, note: 'CHECK: Run, Walk, Cycle']
  BannerImageUrl NVARCHAR(500)
  CreatedAt DATETIME [not null, default: `GETDATE()`]
}

Table Categories {
  CategoryId INT [pk, increment]
  EventId INT [not null]
  Name NVARCHAR(100) [not null]
  MinAge INT
  MaxAge INT
  DistanceKm DECIMAL(6,2)
}

Table Routes {
  RouteId INT [pk, increment]
  EventId INT [not null]
  StartPoint NVARCHAR(200) [not null]
  EndPoint NVARCHAR(200) [not null]
  ElevationGainM DECIMAL(6,2)
  RouteMapUrl NVARCHAR(500)
  Notes NVARCHAR(500)
}

Table Enrolments {
  EnrolmentId INT [pk, increment]
  ParticipantId INT [not null]
  EventId INT [not null]
  CategoryId INT [not null]
  Status NVARCHAR(20) [not null, default: 'Pending', note: 'CHECK: Pending, Confirmed']
  EnrolledAt DATETIME [not null, default: `GETDATE()`]

  indexes {
    (ParticipantId, EventId) [unique]
  }
}

Table Results {
  ResultId INT [pk, increment]
  EnrolmentId INT [not null, unique]
  FinishTime TIME [not null]
  FinishPosition INT [not null]
  TotalFinishers INT [not null]
  CapturedAt DATETIME [not null, default: `GETDATE()`]
}

Ref: Events.OrganiserId > Users.UserId
Ref: Categories.EventId > Events.EventId
Ref: Routes.EventId > Events.EventId
Ref: Enrolments.ParticipantId > Users.UserId
Ref: Enrolments.EventId > Events.EventId
Ref: Enrolments.CategoryId > Categories.CategoryId
Ref: Results.EnrolmentId - Enrolments.EnrolmentId
