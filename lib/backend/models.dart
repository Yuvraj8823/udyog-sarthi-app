
class Jobs {
  final String id;
  final String title;
  final String description;
  final int salary;
  final String sector;
  final String company_image;
  final int experience;
  final String url;

  Jobs({
    this.id = '',
    this.title = '',
    this.description = '',
    this.sector = '',
    this.company_image = 'default.png',
    this.url = 'www.google.com',
    this.salary = 0,
    this.experience = 0
  });

  factory Jobs.fromJson(Map<String, dynamic> json){
    return Jobs(
        id: json['id']??'',
        title: json['title']??'',
        description: json['description']??'',
        sector: json['sector']??'',
        company_image: json['company_image']??'',
        url: json['url']??'',
        salary: json['salary']??0,
        experience: json['experience']??0
    );
  }
}