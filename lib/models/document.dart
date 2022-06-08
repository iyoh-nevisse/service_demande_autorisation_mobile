class Document {
  String? id;
  String? fileName; //cle etrangere du table demande
  String? fileType;
  int? fileSize;
  String? filePath;
  String? tag;
  String? designationAr;
  String? designationFr;

  Document(
      {this.id,
      this.fileName,
      this.fileType,
      this.fileSize,
      this.filePath,
      this.tag,
      this.designationAr,
      this.designationFr});

  factory Document.fromJson(dynamic json) {
    return Document(
      id: json['id'],
      fileName: json['fileName'],
      fileType: json['fileType'],
      fileSize: json['fileSize'],
      filePath: json['filePath'],
      tag: json['tag'],
      // designationAr: json['designationAr'],
      // designationFr: json['designationFr'],
    );
  }

  static List<Document> documentsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Document.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Document { id: $id, fileName: $fileName, fileType:$fileType, fileSize:$fileSize , filePath:$filePath, tag:$tag, designationAr : $designationAr , designationFr :$designationFr }';
  }
}
