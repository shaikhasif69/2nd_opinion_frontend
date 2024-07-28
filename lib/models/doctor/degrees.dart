import 'dart:io';

class Degrees {
  const Degrees({required this.degree, required this.specialization});
  final String degree;
  final String specialization;
}

Map<String, List<String>> medicalDegreesAndSpecializations = {
  'MBBS (Bachelor of Medicine, Bachelor of Surgery)': [
    'Internal Medicine',
    'Surgery',
    'Pediatrics',
    'Obstetrics and Gynecology',
    'Psychiatry',
    'Dermatology',
    'Radiology',
    'Anesthesiology',
    'Orthopedics',
    'ENT (Otorhinolaryngology)',
    'Ophthalmology',
    'Pathology',
    'Cardiology',
    'Nephrology',
    'Pulmonology',
    'Gastroenterology',
    'Hematology',
    'Infectious Diseases',
    'Emergency Medicine',
    'Family Medicine',
    'Endocrinology',
    'Rheumatology',
    'Geriatrics',
    'Urology'
  ],
  'MD (Doctor of Medicine)': [
    'Internal Medicine',
    'Surgery',
    'Pediatrics',
    'Obstetrics and Gynecology',
    'Psychiatry',
    'Dermatology',
    'Radiology',
    'Anesthesiology',
    'Orthopedics',
    'ENT (Otorhinolaryngology)',
    'Ophthalmology',
    'Pathology',
    'Cardiology',
    'Nephrology',
    'Pulmonology',
    'Gastroenterology',
    'Hematology',
    'Infectious Diseases',
    'Emergency Medicine',
    'Family Medicine',
    'Endocrinology',
    'Rheumatology',
    'Geriatrics',
    'Urology'
  ],
  'DO (Doctor of Osteopathic Medicine)': [
    'Internal Medicine',
    'Surgery',
    'Pediatrics',
    'Obstetrics and Gynecology',
    'Psychiatry',
    'Dermatology',
    'Radiology',
    'Anesthesiology',
    'Orthopedics',
    'ENT (Otorhinolaryngology)',
    'Ophthalmology',
    'Pathology',
    'Cardiology',
    'Nephrology',
    'Pulmonology',
    'Gastroenterology',
    'Hematology',
    'Infectious Diseases',
    'Emergency Medicine',
    'Family Medicine',
    'Endocrinology',
    'Rheumatology',
    'Geriatrics',
    'Urology'
  ],
  'MS (Master of Surgery)': [
    'General Surgery',
    'Orthopedic Surgery',
    'Neurosurgery',
    'Cardiothoracic Surgery',
    'Plastic Surgery',
    'Urologic Surgery',
    'Vascular Surgery',
    'Pediatric Surgery',
    'Otorhinolaryngology Surgery',
    'Gynecological Surgery'
  ],
  'MSc (Master of Science) in Medical Sciences': [
    'Biomedical Science',
    'Clinical Research',
    'Epidemiology',
    'Biochemistry',
    'Molecular Biology',
    'Genetics',
    'Immunology',
    'Pharmacology',
    'Physiology',
    'Microbiology'
  ],
  'MPh (Master of Public Health)': [
    'Epidemiology',
    'Biostatistics',
    'Health Policy and Management',
    'Environmental Health',
    'Global Health',
    'Community Health',
    'Health Promotion',
    'Maternal and Child Health',
    'Public Health Nutrition'
  ],
  'MHA (Master of Healthcare Administration)': [
    'Healthcare Management',
    'Healthcare Policy',
    'Healthcare Finance',
    'Healthcare Quality Improvement',
    'Healthcare Operations',
    'Strategic Management in Healthcare',
    'Health Information Systems',
    'Healthcare Leadership'
  ],
  'MBChB (Bachelor of Medicine, Bachelor of Surgery)': [
    'Internal Medicine',
    'Surgery',
    'Pediatrics',
    'Obstetrics and Gynecology',
    'Psychiatry',
    'Dermatology',
    'Radiology',
    'Anesthesiology',
    'Orthopedics',
    'ENT (Otorhinolaryngology)',
    'Ophthalmology',
    'Pathology',
    'Cardiology',
    'Nephrology',
    'Pulmonology',
    'Gastroenterology',
    'Hematology',
    'Infectious Diseases',
    'Emergency Medicine',
    'Family Medicine',
    'Endocrinology',
    'Rheumatology',
    'Geriatrics',
    'Urology'
  ],
  'MMed (Master of Medicine)': [
    'Internal Medicine',
    'Pediatrics',
    'Obstetrics and Gynecology',
    'Surgery',
    'Psychiatry',
    'Dermatology',
    'Anesthesiology',
    'Orthopedics',
    'Radiology',
    'Pathology',
    'Emergency Medicine',
    'Family Medicine',
    'Geriatrics'
  ],
  'PhD (Doctor of Philosophy) in Medical Research': [
    'Medical Science',
    'Biomedical Research',
    'Clinical Research',
    'Public Health Research',
    'Pharmacology',
    'Genetics',
    'Immunology',
    'Neuroscience',
    'Molecular Biology',
    'Epidemiology'
  ],
  'DSc (Doctor of Science) in Medical Sciences': [
    'Biomedical Research',
    'Clinical Research',
    'Immunology',
    'Molecular Biology',
    'Pharmacology',
    'Epidemiology',
    'Genetics',
    'Neuroscience',
    'Public Health Research',
    'Pharmaceutical Sciences'
  ],
  'DPM (Doctor of Podiatric Medicine)': [
    'Podiatric Medicine and Surgery',
    'Podiatric Orthopedics',
    'Podiatric Sports Medicine',
    'Pediatric Podiatry',
    'Geriatric Podiatry'
  ],
  'DDS (Doctor of Dental Surgery)': [
    'General Dentistry',
    'Oral and Maxillofacial Surgery',
    'Orthodontics',
    'Periodontics',
    'Prosthodontics',
    'Endodontics',
    'Pediatric Dentistry',
    'Public Health Dentistry',
    'Oral Pathology',
    'Oral Radiology'
  ],
  'DMD (Doctor of Medicine in Dentistry)': [
    'General Dentistry',
    'Orthodontics',
    'Periodontics',
    'Oral and Maxillofacial Surgery',
    'Prosthodontics',
    'Endodontics',
    'Pediatric Dentistry',
    'Public Health Dentistry',
    'Oral Pathology',
    'Oral Radiology'
  ],
  'BDS (Bachelor of Dental Surgery)': [
    'General Dentistry',
    'Orthodontics',
    'Periodontics',
    'Oral and Maxillofacial Surgery',
    'Prosthodontics',
    'Endodontics',
    'Pediatric Dentistry',
    'Public Health Dentistry',
    'Oral Pathology',
    'Oral Radiology'
  ],
  'MSN (Master of Science in Nursing)': [
    'Nurse Practitioner',
    'Clinical Nurse Specialist',
    'Nurse Anesthetist',
    'Nurse Midwifery',
    'Nursing Education',
    'Nursing Administration',
    'Public Health Nursing'
  ],
  'BSN (Bachelor of Science in Nursing)': [
    'Registered Nursing',
    'Nursing Leadership',
    'Nursing Education',
    'Community Health Nursing',
    'Pediatric Nursing',
    'Geriatric Nursing',
    'Maternal and Child Health Nursing'
  ],
  'NP (Nurse Practitioner)': [
    'Family Nurse Practitioner',
    'Pediatric Nurse Practitioner',
    'Adult-Gerontology Nurse Practitioner',
    'Acute Care Nurse Practitioner',
    'Women Health Nurse Practitioner',
    'Geriatric Nurse Practitioner',
    'Psychiatric-Mental Health Nurse Practitioner'
  ],
  'PA (Physician Assistant)': [
    'General Medicine',
    'Surgical Specialties',
    'Emergency Medicine',
    'Pediatrics',
    'Internal Medicine',
    'Orthopedics',
    'Family Medicine',
    'Psychiatry',
    'Women\'s Health',
    'Cardiology'
  ]
};

Map<String, List<Map<String, File?>>> selectedMedicalDegreesAndSpecializations =
    {};
List<String> searchDegree(String search) {
  List<String> data = [];
  medicalDegreesAndSpecializations.forEach((degree, spe) {
    if (degree.contains(search)) {
      data.add(degree);
    }
  });
  return data;
}
