const String tableContact='tbl_contact';
const String tableContactColId='id';
const String tableContactColName='name';
const String tableContactColMobile='mobile';
const String tableContactColEmail='email';
const String tableContactColAddress='address';
const String tableContactColCompny='company';
const String tableContactColDesignation='designation';
const String tableContactColWebsite='website';
const String tableContactColImage='image';
const String tableContactColFavorite='favorite';

class ContactModel {
  int id;
  String name;
  String mobile;
  String email;
  String address;
  String company;
  String designation;
  String website;
  String image;
  bool favorite;
  ContactModel({
    this.id=-1,
    required this.name,
    required this.mobile,
    this.email='',
    this.address='',
    this.company='',
    this.designation='',
    this.website='',
    this.image='',
    this.favorite=false,
  });
  
  

  ContactModel copyWith({
    int? id,
    String? name,
    String? mobile,
    String? email,
    String? address,
    String? company,
    String? designation,
    String? website,
    String? image,
    bool? favorite,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      address: address ?? this.address,
      company: company ?? this.company,
      designation: designation ?? this.designation,
      website: website ?? this.website,
      image: image ?? this.image,
      favorite: favorite ?? this.favorite,
    );
  }

  Map<String,dynamic> toMap(){
    final map=<String,dynamic>{
      tableContactColName:name,
      tableContactColMobile:mobile,
      tableContactColEmail:email,
      tableContactColCompny:company,
      tableContactColDesignation:designation,
      tableContactColAddress:address,
      tableContactColFavorite:favorite?1:0,
      tableContactColImage:image,
      tableContactColWebsite:website,
    };
    if(id>0){
      map[tableContactColId]=id;
    }
    return map;
  }

  factory ContactModel.fromMap(Map<String,dynamic>map)=>ContactModel(
    name: map[tableContactColName], 
    mobile: map[tableContactColMobile],
    email: map[tableContactColEmail], 
    address: map[tableContactColAddress], 
    company: map[tableContactColCompny], 
    designation: map[tableContactColDesignation], 
    website: map[tableContactColWebsite], 
    image: map[tableContactColImage], 
    favorite: map[tableContactColFavorite]==1? true:false,
    id: map[tableContactColId],
  );

  @override
  String toString() {
    return 'ContactModel(id: $id, name: $name, mobile: $mobile, email: $email, address: $address, company: $company, designation: $designation, website: $website, image: $image, favorite: $favorite)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ContactModel &&
      other.id == id &&
      other.name == name &&
      other.mobile == mobile &&
      other.email == email &&
      other.address == address &&
      other.company == company &&
      other.designation == designation &&
      other.website == website &&
      other.image == image &&
      other.favorite == favorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      mobile.hashCode ^
      email.hashCode ^
      address.hashCode ^
      company.hashCode ^
      designation.hashCode ^
      website.hashCode ^
      image.hashCode ^
      favorite.hashCode;
  }
}
