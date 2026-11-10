# Hamsafar Architecture

The application is organized by feature. Features own their presentation, domain, and data responsibilities; shared infrastructure belongs in core or the application composition root.

## Feature layers

| Layer | Responsibility | May depend on |
| --- | --- | --- |
| Presentation | Pages, widgets, Cubits, and BLoCs. Converts interaction into use-case calls and renders state. | Domain contracts and entities; shared UI/core |
| Domain | Entities, repository contracts, and use cases. Contains application rules and has no Flutter, Supabase, or storage dependency. | Dart and other domain contracts explicitly exposed to the feature |
| Data | Remote/local data sources, serialization models, and repository implementations. | Domain contracts/entities and external SDKs |

The intended dependency direction is:

\`presentation -> domain <- data\`

Data sources are only constructed in the dependency-injection composition root (lib/locator.dart). A presentation class should not query Supabase, access GetStorage, or instantiate a data source.

## Feature boundaries

- auth, friends, home, profile, and trips expose domain contracts for their application operations.
- trip_creation owns the trip draft, edit-form input, save use case, Supabase data source, repository, and creation Cubit. It does not import TripEntity, TripsCubit, or the trips data layer.
- trip_coordination owns the data access and use cases for trip budgets/payments, task management, and departure voting. Its pages receive use cases through constructors.
- settings owns the settings repository and use cases. The GetStorage adapter is in data; the Cubit only coordinates state and use-case calls.
- main_wrapper and splash are presentation-only composition features and do not currently own persistence or remote operations.

Cross-feature collaboration should use a public domain entity or use case, not another feature's page, Cubit, repository implementation, model, or data source. For example, trip creation requests the friends list through the friends domain use case. The route boundary converts an existing trip into TripCreationInitialData before opening the creation feature.

## Dependency injection and routing

lib/locator.dart is the composition root for repositories, data sources, use cases, and long-lived state managers. Route builders inject feature dependencies into page constructors. Routing may coordinate features, but database reads and business operations belong to feature use cases.

Supabase initialization and GetStorage.init() remain in main.dart, which is the application bootstrap. Supabase calls for trip creation, coordination, profile, and other remote features are confined to their data sources.

## Persistence compatibility

This refactor changes Flutter/Dart code organization and dependency direction only. It does not add, alter, or execute Supabase migrations, change tables/RLS/RPC definitions, or change the database schema. Existing RPC names, parameters, and table operations are retained by the corresponding data sources.

## Validation

Run the following from the Flutter project root after fetching dependencies:

\`\`\`bash
dart format lib test
flutter analyze
flutter test
\`\`\`

A feature refactor is complete only after its behavior has been exercised in the app against the existing Supabase project. The remote GitHub edit workflow used for this branch does not provide a local Flutter runtime, so CI or a local Flutter run is still required before merging.
