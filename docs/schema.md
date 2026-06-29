# Database Schema

## profiles
Extends Supabase `auth.users`. Created automatically on signup via trigger.

| column     | type      | notes                    |
|------------|-----------|--------------------------|
| id         | uuid (PK) | = auth.users.id          |
| display_name | text    |                          |
| avatar_url | text      |                          |
| created_at | timestamptz |                        |

## pets
| column     | type        | notes                          |
|------------|-------------|--------------------------------|
| id         | uuid (PK)   |                                |
| owner_id   | uuid (FK)   | -> profiles.id                 |
| name       | text        |                                |
| species    | text        | free text: cat, dog, parrot... |
| breed      | text        | nullable                       |
| dob        | date        | nullable                       |
| photo_url  | text        | Supabase Storage URL           |
| notes      | text        | nullable                       |
| created_at | timestamptz |                                |

## events
| column           | type        | notes                                        |
|------------------|-------------|----------------------------------------------|
| id               | uuid (PK)   |                                              |
| pet_id           | uuid (FK)   | -> pets.id                                   |
| type             | text        | vaccine / grooming / birthday / vet / other  |
| title            | text        |                                              |
| event_date       | timestamptz |                                              |
| notes            | text        | nullable                                     |
| reminder_enabled | bool        | default false                                |
| reminder_offset  | interval    | e.g. 1 day before; nullable                  |
| created_at       | timestamptz |                                              |

## photos
| column     | type        | notes                    |
|------------|-------------|--------------------------|
| id         | uuid (PK)   |                          |
| pet_id     | uuid (FK)   | -> pets.id               |
| url        | text        | Supabase Storage URL     |
| caption    | text        | nullable                 |
| taken_at   | timestamptz | nullable (EXIF or manual)|
| created_at | timestamptz |                          |

## measurements
| column      | type        | notes              |
|-------------|-------------|--------------------|
| id          | uuid (PK)   |                    |
| pet_id      | uuid (FK)   | -> pets.id         |
| weight_kg   | numeric     | nullable           |
| height_cm   | numeric     | nullable           |
| measured_at | timestamptz |                    |
| notes       | text        | nullable           |

## courses
| column      | type      | notes                              |
|-------------|-----------|------------------------------------|
| id          | uuid (PK) |                                    |
| title       | text      |                                    |
| description | text      |                                    |
| species     | text      | nullable - null means all species  |
| content     | jsonb     | structured lesson content          |
| created_at  | timestamptz |                                  |

## course_progress
| column      | type        | notes                  |
|-------------|-------------|------------------------|
| id          | uuid (PK)   |                        |
| user_id     | uuid (FK)   | -> profiles.id         |
| course_id   | uuid (FK)   | -> courses.id          |
| completed_at | timestamptz | nullable - in progress|
| progress    | jsonb       | lesson-level tracking  |
