# Task Manager Project - Team Task Management System 🎯

---

## 📋 Project Introduction



This project will give you an excellent opportunity to apply what you've learned in building a complete application that solves a real workplace problem. You will build a system that helps teams organize their tasks and track their progress efficiently, where managers can create tasks and distribute them to team members, while employees can track their tasks and update their status.

Through this project, you will learn:
- State management using **Bloc Pattern**
- Working with cloud databases **Supabase**
- Using **Bloc** for State mangmant
- **Git_it** dependency injection
- Building professional and responsive user interfaces
- Handling real-time updates
- Managing permissions and different roles
- Using **Git** for version control

**Submission Date:** Next Sunday (9/11/2025) 
**Type Project:** Work as team (With your team)
**Submission Method:** Github Class room

We wish you an enjoyable and beneficial experience! 💪

---

## 🎯 Technical Requirements

### 1. Database and Backend
- **Supabase** for database and authentication management
- **Authentication** (Email/Password)
- **Real-time Subscriptions** for instant updates

### 2. State Management and Tools
- **Bloc Pattern** for State Management
- **Git_it** dependency injection
- **Git & GitHub** for version control
- **Local Storage Service** for saving data locally when needed

### 3. Functional Requirements
- Login and logout
- Different permissions for each role (Manager/Employee)
- Separate user interfaces based on role
- Task system

---

## ✅ Required Tasks (Tasks Breakdown)

### Phase 1: Setup and Configuration
- [ ] Create new Flutter project
- [ ] Setup Supabase Project
- [ ] Create database tables (see tables below)
- [ ] Setup Authentication in Supabase
- [ ] Initialize Git Repository
- [ ] Add required libraries (Dependencies)

### Phase 2: Authentication System
- [ ] Login screen
- [ ] Sign Up screen with role selection
- [ ] Auth Bloc
- [ ] Local Storage for saving user data
- [ ] Verify user permissions

### Phase 3: Manager Interface (Manager Dashboard)
**Essentials (Must Have):**
- [ ] Main Dashboard with overview
- [ ] Create new task screen
- [ ] Assign task to specific employee
- [ ] Set Priority and Due Date
- [ ] Display list of all tasks
- [ ] Filter tasks (All/In Progress/Completed)
- [ ] Edit Tasks
- [ ] Delete Tasks
- [ ] Display Charts for basic statistics
- [ ] Highlight Overdue Tasks

**Optional (Nice to Have):**
- [ ] Advanced task search
- [ ] Detailed performance reports
- [ ] Statistics for each employee

### Phase 4: Employee Interface (Employee Dashboard)
**Essentials (Must Have):**
- [ ] Display tasks assigned to employee
- [ ] Update task status (Pending → In Progress → Completed)
- [ ] Display complete task details
- [ ] Add comments to task

**Optional (Nice to Have):**
- [ ] Personal statistics for employee
- [ ] Display tasks in Calendar View
- [ ] Reminders for deadlines

### Phase 5: Real-time Updates
- [ ] Real-time subscriptions for new tasks
- [ ] Instant update of task status
- [ ] Instant notifications for manager/employee

### Phase 6: Improvements and Finalization
- [ ] Improve UI/UX
- [ ] Error Handling
- [ ] Loading States
- [ ] Responsive Design
- [ ] Write comprehensive README.md

---

## 📖 User Stories

### 🔷 Manager User Stories

#### Essential:
1. **As a manager, I want to create a new task**
   - So I can distribute work to the team
   - I should be able to write a title, description, set priority and deadline

2. **As a manager, I want to assign task to a specific employee**
   - So the employee knows their responsibilities
   - I should see a list of all available employees

3. **As a manager, I want to see all tasks and their status**
   - So I can track work progress in the team
   - I should see tasks classified by status (pending/in progress/completed)

4. **As a manager, I want to edit or delete any task**
   - So I can correct mistakes or cancel unnecessary tasks
   - A confirmation message should appear before deletion

5. **As a manager, I want to see statistics of overdue tasks**
   - So I can track tasks that have passed their deadline
   - They should appear with a clear alert

6. **As a manager, I want to see a Dashboard with statistics**
   - So I get a quick overview of team performance
   - It should contain Charts showing task distribution

#### Optional:
7. **As a manager, I want to filter tasks by multiple criteria**
   - So I can find specific tasks quickly
   - I should be able to filter by (status/employee/priority/date)

8. **As a manager, I want to see detailed performance reports**
   - So I can evaluate each employee's performance
   - Should include: number of completed tasks, average completion time, percentage of overdue tasks

---

### 🔶 Employee User Stories

#### Essential:
1. **As an employee, I want to see all tasks assigned to me**
   - So I know what I need to accomplish
   - I should see tasks sorted by priority and deadline

2. **As an employee, I want to update task status**
   - So I can inform the manager of my work progress
   - I should be able to change status from (pending → in progress → completed)

3. **As an employee, I want to see complete task details**
   - So I clearly understand what's required of me
   - I should see (title, description, priority, deadline, comments)

4. **As an employee, I want to add a comment to the task**
   - So I can communicate with the manager about the task
   - Comments should appear with date and time of addition

#### Optional:
5. **As an employee, I want to see my personal performance statistics**
   - So I can track my performance development
   - Should include: number of completed tasks, tasks in progress, completion percentage

6. **As an employee, I want to see tasks in Calendar view**
   - So I can better plan my schedule
   - Tasks should appear on the calendar according to deadlines

7. **As an employee, I want to receive reminders for deadlines**
   - So I don't forget urgent tasks
   - I should receive a notification before the deadline with sufficient time

---

## 🔄 Flow Diagrams

### 1️⃣ Authentication Flow

```
Start
   ↓
[Splash Screen]
   ↓
Is user logged in?
   ↓
   ├─→ Yes → Determine role
   │            ↓
   │     ┌──────────┴──────────┐
   │     ↓                     ↓
   │  [Manager Dashboard]  [Employee Dashboard]
   │
   └─→ No → [Login Screen]
              ↓
         ┌────┴────┐
         ↓         ↓
      [Login]   [Sign Up]
         │         │
         └────┬────┘
              ↓
        Successful registration?
              ↓
         ┌────┴────┐
         ↓         ↓
       Yes       No (Error message)
         ↓
   [Determine role]
         ↓
   ┌─────────┴─────────┐
   ↓                   ↓
Manager Dashboard   Employee Dashboard
```

---

### 2️⃣ Manager Flow - Task Management

```
[Manager Dashboard]
   ↓
   ├──→ [Display Statistics]
   │       ↓
   │    - Number of tasks (All/In Progress/Completed)
   │    - Charts
   │    - Overdue tasks
   │
   ├──→ [Create New Task]
   │       ↓
   │    Fill data:
   │    - Title
   │    - Description
   │    - Priority
   │    - Deadline
   │    - Assign employee
   │       ↓
   │    [Save Task]
   │       ↓
   │    Notification to assigned employee
   │
   ├──→ [View All Tasks]
   │       ↓
   │    ┌─────────────────┐
   │    │ Filter by:      │
   │    │ - Status        │
   │    │ - Employee      │
   │    │ - Priority      │
   │    └─────────────────┘
   │       ↓
   │    Select task
   │       ↓
   │    [Task Details]
   │       ↓
   │    ┌────┴────┐
   │    ↓         ↓
   │  [Edit]   [Delete]
   │    │         │
   │    └────┬────┘
   │         ↓
   │    [Update/Delete in DB]
   │         ↓
   │    [Real-time Update]
   │
   └──→ [Performance Reports] (Optional)
          ↓
       - Each employee's performance
       - Detailed statistics
```

---

### 3️⃣ Employee Flow - Task Management

```
[Employee Dashboard]
   ↓
   ├──→ [My Assigned Tasks]
   │       ↓
   │    Display tasks classified:
   │    - Pending
   │    - In Progress
   │    - Completed
   │       ↓
   │    Select task
   │       ↓
   │    [Task Details]
   │       ↓
   │       ├──→ [Update Status]
   │       │       ↓
   │       │    Pending → In Progress → Completed
   │       │       ↓
   │       │    [Save Update]
   │       │       ↓
   │       │    Notification to manager
   │       │
   │       └──→ [Add Comment]
   │               ↓
   │            Write comment
   │               ↓
   │            [Save Comment]
   │               ↓
   │            Appears in comments log
   │
   └──→ [My Statistics] (Optional)
          ↓
       - Number of completed tasks
       - Tasks in progress
       - Completion percentage
       - Calendar View (Optional)
```

---

### 4️⃣ Real-time Updates Flow

```
[Event in System]
   ↓
   ├──→ New task created
   │       ↓
   │    Supabase Real-time Trigger
   │       ↓
   │    [Notification to assigned employee]
   │       ↓
   │    Update task list automatically
   │
   ├──→ Task status changed
   │       ↓
   │    Supabase Real-time Trigger
   │       ↓
   │    [Notification to manager]
   │       ↓
   │    Update Dashboard automatically
   │
   └──→ Comment added
          ↓
       Supabase Real-time Trigger
          ↓
       Update details page for everyone
```

---

## 🗄️ Database Schema

### 📊 Required Tables:

#### 1️⃣ Profiles Table
```sql
CREATE TABLE profiles (
    id UUID REFERENCES auth.users(id) PRIMARY KEY,
    full_name TEXT NOT NULL,
    role user_role DEFAULT 'employee',
    avatar_url TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);
```

**Fields:**
- `id`: User identifier (UUID) - linked to authentication table
- `full_name`: Full name
- `role`: Role (manager or employee)
- `avatar_url`: Profile picture link (optional)
- `created_at`: Account creation date

---

#### 2️⃣ Tasks Table
```sql
CREATE TABLE tasks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    status task_status DEFAULT 'pending',
    priority task_priority DEFAULT 'medium',
    due_date TIMESTAMP,
    
    -- Relationships
    created_by UUID REFERENCES auth.users(id) NOT NULL,
    assigned_to UUID REFERENCES auth.users(id),
    
    -- Dates
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    completed_at TIMESTAMP
);
```

**Fields:**
- `id`: Task identifier (UUID)
- `title`: Task title
- `description`: Detailed task description
- `status`: Status (pending, in_progress, completed, cancelled)
- `priority`: Priority (low, medium, high, urgent)
- `due_date`: Deadline
- `created_by`: Who created the task (manager)
- `assigned_to`: Which employee the task is assigned to
- `created_at`: Task creation date
- `updated_at`: Last update date
- `completed_at`: Task completion date

---

#### 3️⃣ Task Comments Table
```sql
CREATE TABLE task_comments (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    task_id UUID REFERENCES tasks(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);
```

**Fields:**
- `id`: Comment identifier
- `task_id`: Related task identifier
- `user_id`: Who wrote the comment
- `comment`: Comment text
- `created_at`: Addition date

---

### 📌 Custom Types (Enums)

```sql
-- User role type
CREATE TYPE user_role AS ENUM ('manager', 'employee');

-- Task status type
CREATE TYPE task_status AS ENUM ('pending', 'in_progress', 'completed', 'cancelled');

-- Task priority type
CREATE TYPE task_priority AS ENUM ('low', 'medium', 'high', 'urgent');
```

---

### 🔗 Table Relationships

```
auth.users (Supabase Auth)
    ↓
    ├─→ profiles (1:1)
    │     ↓
    │     └─→ role (manager/employee)
    │
    ├─→ tasks (1:Many) as created_by
    │     ↓
    │     └─→ tasks (1:Many) as assigned_to
    │
    └─→ task_comments (1:Many)

tasks
    ↓
    └─→ task_comments (1:Many)
```

---

### 📸 Visual Database Diagram

```
┌─────────────────────┐
│   auth.users        │
│  (Supabase Auth)    │
└──────────┬──────────┘
           │
           ├──────────────────────────┐
           │                          │
           ↓                          ↓
┌──────────────────────┐   ┌──────────────────────┐
│     profiles         │   │       tasks          │
├──────────────────────┤   ├──────────────────────┤
│ • id (FK)            │   │ • id (PK)            │
│ • full_name          │   │ • title              │
│ • role               │   │ • description        │
│ • avatar_url         │   │ • status             │
│ • created_at         │   │ • priority           │
└──────────────────────┘   │ • due_date           │
                           │ • created_by (FK)    │
                           │ • assigned_to (FK)   │
                           │ • created_at         │
                           │ • updated_at         │
                           │ • completed_at       │
                           └──────────┬───────────┘
                                      │
                                      ↓
                           ┌──────────────────────┐
                           │   task_comments      │
                           ├──────────────────────┤
                           │ • id (PK)            │
                           │ • task_id (FK)       │
                           │ • user_id (FK)       │
                           │ • comment            │
                           │ • created_at         │
                           └──────────────────────┘
```

---

## 📝 Important Notes

### ✅ Evaluation Criteria:
1. **Basic Functions (60%)**
   - Authentication system works correctly
   - Manager can create, edit, and delete tasks
   - Employee can view and update assigned tasks
   
2. **State Management (20%)**
   - Proper use of Bloc
   - Handle all states (Loading, Success, Error)

3. **UI/UX (10%)**
   - Clean and easy-to-use interfaces
   - Responsive Design
   - Clear error handling for user

4. **Code and Best Practices (10%)**
   - Clean and organized code
   - Proper use of Git
   - Clear README.md

### 💡 Tips for Success:
- Start with essential requirements (Must Have) before optional ones
- Work on one feature at a time and test it well
- Use Git Commits regularly
- Ask for help if you face difficulties
- Test the application from both roles' perspectives

---

## 📚 Helpful Resources:
- [Supabase Documentation](https://supabase.com/docs)
- [Flutter Bloc Documentation](https://bloclibrary.dev/)
- [Flutter Documentation](https://flutter.dev/docs)

---

**Good luck everyone! 🚀**
