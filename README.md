# Task Management System

A modern task management system built with Flutter, BLoC pattern, and Supabase backend. The application provides different interfaces and functionalities for managers and employees.

## Features

### Authentication
- User registration with role selection (Manager/Employee)
- Secure login system
- Role-based access control

### Manager Features
- Dashboard with comprehensive task overview
- Create, edit, and delete tasks
- Assign tasks to employees
- View task statistics and performance metrics
- Filter and search tasks
- Real-time task updates
- Add comments to tasks

### Employee Features
- View assigned tasks
- Update task status
- Personal performance dashboard
- Task completion statistics
- Real-time notifications for new assignments

### Task Management
- Priority levels (Urgent, High, Medium, Low)
- Status tracking (Pending, In Progress, Completed, Cancelled)
- Due date management
- Task comments system
- Real-time updates using Supabase subscriptions

## Technical Stack

- **Frontend**: Flutter
- **State Management**: BLoC (Business Logic Component)
- **Backend**: Supabase
- **Dependencies**:
  - flutter_bloc
  - go_router
  - get_it (Dependency Injection)
  - supabase_flutter
  - equatable
  - fl_chart (for statistics visualization)
  - flutter_screenutil (for responsive design)

## Project Structure

```
lib/
├── core/
│   ├── di/
│   ├── models/
│   ├── router/
│   ├── services/
│   ├── theme/
│   └── utils/
├── features/
│   ├── login/
│   ├── signup/
│   ├── manager/
│   │   ├── manager_dashboard/
│   │   └── statistics/
│   └── employee/
└── main.dart
```

## Getting Started

1. Clone the repository
2. Set up Supabase backend
3. Configure environment variables
4. Run `flutter pub get`
5. Run `flutter run`

## Authentication Flow

1. Users can register with email/password
2. Role selection during registration
3. Login redirects to appropriate dashboard based on role
4. Session management using Supabase

## Contribution

Feel free to submit issues and enhancement requests.

## License

[Your License Here]
