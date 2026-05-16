import 'package:go_router/go_router.dart';

import 'data/resume_data.dart';
import 'ui/activities/outside_activities_view.dart';
import 'ui/experience/experience_detail_view.dart';
import 'ui/experience/experience_detail_view_model.dart';
import 'ui/experience/experience_list_view.dart';
import 'ui/home/home_view.dart';
import 'ui/projects/personal_projects_view.dart';
import 'ui/skills/skills_view.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeView()),
    GoRoute(
      path: '/experience',
      builder: (context, state) => const ExperienceListView(),
    ),
    GoRoute(
      path: '/experience/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        final experience = experiences.firstWhere(
          (item) => item.id == id,
          orElse: () => experiences.first,
        );
        return ExperienceDetailView(
          viewModel: ExperienceDetailViewModel(experience: experience),
        );
      },
    ),
    GoRoute(
      path: '/projects',
      builder: (context, state) => const PersonalProjectsView(),
    ),
    GoRoute(
      path: '/activities',
      builder: (context, state) => const OutsideActivitiesView(),
    ),
    GoRoute(path: '/skills', builder: (context, state) => const SkillsView()),
  ],
);
