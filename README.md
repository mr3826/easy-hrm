# Easy HRM

Easy HRM is a modern, lightweight mobile HR management app for employees and managers. This repository is a rebrand of the original Payrun mobile app and provides features such as:

- Leave management and approvals
- Time tracking and timelogs
- Employee directory and profiles
- Notifications and activity timeline
- Multi-organization support

This project is intended as a starter for teams who want an enterprise-ready Flutter codebase with a focus on maintainability and clean architecture.

## Brand & Theme

Easy HRM uses a teal primary color (#00796B) with an amber accent (#FFA000). The app theme and core color tokens are defined in `lib/utils/app_color.dart` and applied via `lib/utils/theme.dart`.

## Quick Start

Prerequisites:

- Flutter SDK (stable channel)
- Dart SDK compatible with Flutter
- `gh` CLI authenticated (for repo operations)

Install dependencies and run the app:

```bash
flutter pub get
flutter run
```

## Development Notes

- Package name remains `payrun_mobile` to preserve internal imports; repository and UI are rebranded to Easy HRM.
- Environment files are under the `env/` folder and updated to `easyhrm` endpoints.
- Android application label updated in `android/app/src/main/AndroidManifest.xml`.

## Contributing

If you'd like to contribute, open issues and pull requests against the `easy-hrm` repository on GitHub.

## License

MIT

---

For full developer guidelines and AI-backed architecture prompts, the `external/senior-mobile-architect` folder contains senior-engineer skill templates you can adopt (prompts, workflows, and Copilot instruction templates).
