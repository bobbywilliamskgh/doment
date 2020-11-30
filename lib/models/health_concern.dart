class HealthConcern {
  final String id;
  final String title;
  final String image;

  const HealthConcern({
    this.id,
    this.title,
    this.image,
  });
}

class HealthConcerns {
  static const List<HealthConcern> healthConcerns = [
    HealthConcern(
      id: 'hc1',
      title: 'Women\'s Health',
      image: 'assets/images/mother.png',
    ),
    HealthConcern(
      id: 'hc2',
      title: 'Skin & Hair',
      image: 'assets/images/dermatitis.png',
    ),
    HealthConcern(
      id: 'hc3',
      title: 'Child Specialist',
      image: 'assets/images/baby-boy.png',
    ),
    HealthConcern(
      id: 'hc4',
      title: 'General Physician',
      image: 'assets/images/stethoscope.png',
    ),
    HealthConcern(
      id: 'hc5',
      title: 'Dental Care',
      image: 'assets/images/dental-checkup.png',
    ),
    HealthConcern(
      id: 'hc6',
      title: 'Ear Nose Throat',
      image: 'assets/images/head.png',
    ),
    HealthConcern(
      id: 'hc7',
      title: 'Homoeopathy',
      image: 'assets/images/pills.png',
    ),
    HealthConcern(
      id: 'hc8',
      title: 'Bone and Joints',
      image: 'assets/images/femur.png',
    ),
    HealthConcern(
      id: 'hc9',
      title: 'Sex Specialist',
      image: 'assets/images/sex.png',
    ),
    HealthConcern(
      id: 'hc10',
      title: 'Eye Specialist',
      image: 'assets/images/witness.png',
    ),
    HealthConcern(
      id: 'hc11',
      title: 'Digestive Issues',
      image: 'assets/images/stomach.png',
    ),
    HealthConcern(
      id: 'hc12',
      title: 'Mental Wellness',
      image: 'assets/images/stress-management.png',
    ),
    HealthConcern(
      id: 'hc13',
      title: 'Physioterapy',
      image: 'assets/images/physiotherapy.png',
    ),
    HealthConcern(
      id: 'hc14',
      title: 'Diabetes Management',
      image: 'assets/images/diabetes-test.png',
    ),
    HealthConcern(
      id: 'hc15',
      title: 'Brain and Nerves ',
      image: 'assets/images/brain.png',
    ),
    HealthConcern(
      id: 'hc16',
      title: 'General Surgery',
      image: 'assets/images/surgeon.png',
    ),
    HealthConcern(
      id: 'hc17',
      title: 'Lungs and Breathing',
      image: 'assets/images/lungs.png',
    ),
    HealthConcern(
      id: 'hc18',
      title: 'Heart',
      image: 'assets/images/cardiogram.png',
    ),
    HealthConcern(
      id: 'hc19',
      title: 'Cancer',
      image: 'assets/images/cancer.png',
    ),
  ];
}
