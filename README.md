# Rolê — Group Hangout Coordination App

A Rails web application to coordinate when friends are available and find the best time for group hangouts.

**Status**: Early MVP — Feature F1 (Availability Slots) functional.

---

## Current State

### What's Working ✅

- **User Authentication** — Rails 8 built-in auth (`has_secure_password`)
- **Availability Grid (F1)** — Weekly calendar grid for marking personal availability
  - Mark slots as available, flexible, or empty
  - Interactive grid with Stimulus.js + Turbo Streams
  - No page reload on toggle
  - PostgreSQL persistence with unique constraints
  - CSS Grid layout with visual states (green/yellow/gray)

### What's Missing 🚧

- **F2 — Groups & Membership** — Create groups, invite friends
- **F3 — Overlap Calculation** — Display collective availability across group
- **F4 — Rolê (Events)** — Create and manage group hangouts
- **F5 — Notifications** — Real-time updates via ActionCable
- **Calendar Sync** — Google Calendar / Apple Calendar integration
- **Mobile UI Polish** — Responsive improvements for smaller screens
- **Test Coverage** — Unit and integration tests

---

## Tech Stack

- **Framework**: Ruby on Rails 8.0
- **Database**: PostgreSQL 14+
- **Frontend**: Stimulus.js + Turbo Streams + CSS Grid
- **Authentication**: Rails 8 native `authentication` generator
- **Ruby**: 3.3+

---

## Prerequisites

- Ruby 3.3+
- Node.js 18+ (for Rails asset pipeline)
- PostgreSQL 14+
- Git

---

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/role-app.git
cd role-app
```

### 2. Install Dependencies

```bash
bundle install
npm install  # or yarn install
```

### 3. Configure Database

```bash
rails db:create
rails db:migrate
```

### 4. Create First User (Console)

```bash
rails console
```

```ruby
User.create!(
  email_address: "your@email.com",
  password: "password123",
  password_confirmation: "password123"
)
exit
```

### 5. Start the Server

```bash
./bin/dev  # starts Rails + Webpack/esbuild concurrently
```

Server runs at `http://localhost:3000`

### 6. Login & Test

- Navigate to `http://localhost:3000/sessions/new`
- Use credentials from step 4
- After login, go to `/availability` to see the grid

---

## Deployment to GitHub

### First Time Setup

```bash
# Initialize git if not already done
git init

# Add remote (replace with your repo URL)
git remote add origin https://github.com/YOUR_USERNAME/role-app.git

# Create initial commit
git add .
git commit -m "chore: initial commit - F1 availability slots MVP"

# Push to GitHub
git branch -M main
git push -u origin main
```

### For Existing GitHub Repo

```bash
git add .
git commit -m "feat: add availability grid feature (F1)"
git push origin main
```

---

## Project Structure

```
app/
├── controllers/
│   ├── application_controller.rb
│   ├── availabilities_controller.rb      # F1
│   └── sessions_controller.rb             # Auth
├── models/
│   ├── user.rb
│   └── availability_slot.rb              # F1 domain entity
├── views/
│   ├── availabilities/
│   │   ├── show.html.erb                 # F1 grid
│   │   └── _cell.html.erb                # F1 cell partial
│   └── sessions/                         # Auth views
├── javascript/
│   └── controllers/
│       └── slot_controller.js            # F1 Stimulus
└── assets/
    └── stylesheets/
        └── application.css               # F1 grid styles

config/
├── routes.rb                             # Routing config
└── database.yml                          # DB config

db/
├── migrate/
│   ├── *_create_users.rb
│   └── *_create_availability_slots.rb    # F1
└── seeds.rb                              # Optional fixtures

```

---

## Running Tests (TODO)

```bash
rails test                    # Run all tests
rails test:system             # System/browser tests
```

---

## Next Steps to Implement

### F2 — Groups & Membership (Priority: High)
- [ ] Create `Group` model
- [ ] Create `GroupMembership` join table (has_many :through)
- [ ] Implement `GroupsController` (CRUD)
- [ ] Add group selection UI to availability view
- [ ] Authorization checks (user can only edit own slots)

### F3 — Overlap Calculation (Priority: High)
- [ ] Aggregate availability across group members
- [ ] Build overlap score query (SQL window functions or Rails)
- [ ] Display collective heatmap view
- [ ] Rank best time slots by density

### F4 — Rolê (Events)
- [ ] Create `Rolê` model with state machine (proposed → confirmed → completed)
- [ ] `RoleController` — create, confirm, view, cancel
- [ ] Rolê CRUD interface
- [ ] Participant status tracking

### F5 — Notifications
- [ ] ActionCable setup for real-time updates
- [ ] Turbo Streams broadcast on availability changes
- [ ] Email notifications for group activity
- [ ] Solid Queue background jobs

### Calendar Integrations
- [ ] Google Calendar OAuth2 flow
- [ ] Apple Calendar sync (EventKit)
- [ ] Export rolês to external calendars
- [ ] Auto-populate busy blocks from connected calendars

### Testing & Polish
- [ ] Full test coverage for models and controllers
- [ ] System tests for happy path flows
- [ ] Error handling and validation messages
- [ ] Mobile responsive design improvements
- [ ] Dark mode toggle (optional)

---

## Development Workflow

### Creating a New Feature Branch

```bash
git checkout -b feature/f2-groups
# Make changes
git add .
git commit -m "feat: implement groups and membership (F2)"
git push origin feature/f2-groups
# Open Pull Request on GitHub
```

### Migrations

```bash
# Generate migration
rails generate migration CreateRoles name:string description:text user:references

# Apply
rails db:migrate

# Rollback (if needed)
rails db:rollback
```

### Console for Quick Testing

```bash
rails console
user = User.first
user.availability_slots.count
# Play with models interactively
```

---

## Troubleshooting

### Database Connection Error
```bash
rails db:create
rails db:migrate
```

### Assets not loading (CSS/JS)
```bash
./bin/dev          # Restart dev server
rails assets:precompile  # Force recompile
```

### Port 3000 already in use
```bash
rails s -p 3001    # Use different port
```

---

## Contributing

1. Fork the repo
2. Create feature branch (`git checkout -b feature/name`)
3. Commit changes (`git commit -m "feat: description"`)
4. Push to branch (`git push origin feature/name`)
5. Open Pull Request

---

## License

MIT

---

## Author

Dennis Silva (@dennsilva)  
São Paulo, Brazil

---

## Resources

- [Rails 8 Guides](https://guides.rubyonrails.org)
- [Stimulus.js](https://stimulus.hotwired.dev)
- [Turbo Streams](https://turbo.hotwired.dev/handbook/streams)
- [PostgreSQL Docs](https://www.postgresql.org/docs/)

