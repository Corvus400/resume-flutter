import '../../data/models/personal_project.dart';
import '../../data/resume_data.dart';

class PersonalProjectsViewModel {
  List<PersonalProject> get projects => personalProjects;

  String get countLabel => '${personalProjects.length} repositories';
}
