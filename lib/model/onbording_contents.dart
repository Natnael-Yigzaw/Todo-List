class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Task Management",
    image: "assets/images/firstscreen.png",
    desc: "All your to-do lists are easily manageable and accessble any time when you need them.",
  ),
  OnboardingContents(
    title: "Quick Access Menu",
    image: "assets/images/drawer.png",
    desc:
        "Access your today and favorite tasks from the appbar drawer.",
  ),
  OnboardingContents(
    title: "Favorite Task",
    image: "assets/images/descriptionscreen.png",
    desc:
        "Make any task your favorite by pressing the star icon on the task description screen.",
  ),
];