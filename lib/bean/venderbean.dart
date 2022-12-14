class VendorList{
  dynamic vendor_category_id;
  dynamic category_name;
  dynamic category_image;
  dynamic ui_type;
  List<dynamic> vendors;

  VendorList(this.vendor_category_id, this.category_name, this.category_image,this.ui_type,this.vendors);

  factory VendorList.fromJson(dynamic json) {
    return VendorList(json['vendor_category_id'], json['category_name'], json['category_image'],json['ui_type'],json['vendors']);
  }

  @override
  String toString() {
    return 'VendorList{vendor_category_id: $vendor_category_id, category_name: $category_name, category_image: $category_image, ui_type: $ui_type, vendors: $vendors}';
  }
}