class JobApplicationPreviewModel {
  GetJobApplicationPreview? getJobApplicationPreview;

  JobApplicationPreviewModel({this.getJobApplicationPreview});

  JobApplicationPreviewModel.fromJson(Map<String, dynamic> json) {
    getJobApplicationPreview = json['getJobApplicationPreview'] != null
        ? new GetJobApplicationPreview.fromJson(
        json['getJobApplicationPreview'])
        : null;
  }


}

class GetJobApplicationPreview {
  List<Data>? data;

  GetJobApplicationPreview({this.data});

  GetJobApplicationPreview.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }


}

class Data {
  String? id;

  @override
  String toString() {
    return 'Data{id: $id, formFields: $formFields, isDuplicatable: $isDuplicatable, isQuestionable: $isQuestionable, name: $name, organizationId: $organizationId}';
  }

  List<FormFields>? formFields;
  bool? isDuplicatable;
  bool? isQuestionable;
  String? name;
  String? organizationId;

  Data(
      {this.id,
        this.formFields,
        this.isDuplicatable,
        this.isQuestionable,
        this.name,
        this.organizationId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['form_fields'] != null) {
      formFields = <FormFields>[];
      json['form_fields'].forEach((v) {
        formFields!.add(new FormFields.fromJson(v));
      });
    }
    isDuplicatable = json['is_duplicatable'];
    isQuestionable = json['is_questionable'];
    name = json['name'];
    organizationId = json['organization_id'];
  }
}

class FormFields {
  String? id;
  String? name;
  String? type;
  dynamic priority;
  String? fieldWidth;
  dynamic isRequired;
  List<FormFieldValues>? formFieldValues;
  List<FormFields>? formFields;


  @override
  String toString() {
    return 'FormFields{id: $id, name: $name, type: $type, priority: $priority, fieldWidth: $fieldWidth, isRequired: $isRequired, formFieldValues: $formFieldValues, formFields: $formFields}';
  }

  FormFields(
      {this.id,
        this.name,
        this.type,
        this.priority,
        this.fieldWidth,
        this.isRequired,
        this.formFieldValues,
        this.formFields});


  FormFields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    priority = json['priority'];
    fieldWidth = json['field_width'];
    isRequired = json['is_required'];
    if (json['form_field_values'] != null) {
      formFieldValues = <FormFieldValues>[];
      json['form_field_values'].forEach((v) {
        formFieldValues!.add(new FormFieldValues.fromJson(v));
      });
    }
    if (json['form_fields'] != null) {
      formFields = <FormFields>[];
      json['form_fields'].forEach((v) {
        formFields!.add(new FormFields.fromJson(v));
      });
    }
  }


}

class FormFieldValues {
  String? id;
  File? file;
  String? value;

  FormFieldValues({this.id, this.file, this.value});

  FormFieldValues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'] != null ? new File.fromJson(json['file']) : null;
    value = json['value'];
  }

}

class File {
  String? id;
  String? key;
  String? name;

  File({this.id, this.key, this.name});

  File.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
  }

}

class FormFields1 {
  String? id;
  String? name;
  String? type;
  int? priority;
  String? fieldWidth;
  bool? isRequired;
  String? groupSerialId;
  List<FormFieldValues>? formFieldValues;

  FormFields1(
      {this.id,
        this.name,
        this.type,
        this.priority,
        this.fieldWidth,
        this.isRequired,
        this.groupSerialId,
        this.formFieldValues});

  @override
  String toString() {
    return 'FormFields1{id: $id, name: $name, type: $type, priority: $priority, fieldWidth: $fieldWidth, isRequired: $isRequired, groupSerialId: $groupSerialId, formFieldValues: $formFieldValues}';
  }
  FormFields1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    priority = json['priority'];
    fieldWidth = json['field_width'];
    isRequired = json['is_required'];
    groupSerialId = json['group_serial_id'];
    if (json['form_field_values'] != null) {
      formFieldValues = <FormFieldValues>[];
      json['form_field_values'].forEach((v) {
        formFieldValues!.add(new FormFieldValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['priority'] = this.priority;
    data['field_width'] = this.fieldWidth;
    data['is_required'] = this.isRequired;
    data['group_serial_id'] = this.groupSerialId;

    return data;
  }
}

class FormFieldValues1 {
  String? id;
  Null? file;
  String? value;

  FormFieldValues1({this.id, this.file, this.value});

  FormFieldValues1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file'] = this.file;
    data['value'] = this.value;
    return data;
  }
}
