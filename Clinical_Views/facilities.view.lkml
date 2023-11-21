view: bp_facilities{
  view_label: "BP Facilities"
  sql_table_name: dbo.lookBPFacility;;


  dimension: facility_skey {
    type: number
    sql: ${TABLE}.FacilitySkey ;;
    primary_key: yes
  }

  dimension: facility_name {
    group_label: "Facility Info"
    type: string
    sql: ${TABLE}.FacilityName ;;
##    suggest_explore: bp_facility_suggestions
##    suggest_dimension: bp_facility_suggestions.facility_name
  }

  dimension: facility_owner {
    type: string
    sql: ${TABLE}.FacilityOwner ;;
  }

  dimension: facility_benchmark_code {
    group_label: "Facility Info"
    label: "Benchmarck Code"
    type: string
    sql: ${TABLE}.FacilityBenchmarkCode ;;
  }

  dimension: facility_direct_parent {
    type: string
    sql: ${TABLE}.FacilityDirectParent ;;
  }

  dimension: facility_entity_code {
    type: string
    sql: ${TABLE}.FacilityEntityCode ;;
  }

  dimension: entity_top_parent {
    type: string
    sql: ${TABLE}.EntityTopParent ;;
  }

  dimension: facility_state {
    label: "State"
    type: string
    sql: ${TABLE}.FacilityState ;;
  }

  dimension: facility_region {
    label: "Region"
    type: string
    sql: ${TABLE}.FacilityRegion ;;
  }

  dimension: facility_custom_region {
    label: "Custom Region"
    type: string
    sql: ${TABLE}.FacilityCustomRegion ;;
  }

  dimension: facility_patient_volume {
    type: number
    sql: ${TABLE}.FacilityPatientVolume ;;
  }

  dimension: facility_beds {
    type: number
    sql: ${TABLE}.FacilityBeds ;;
  }

  dimension: facility_size {
    type: string
    sql: ${TABLE}.FacilitySize ;;
  }

  dimension: facility_academic_med_ctr {
    label: "Academic Medical Center"
    type: string
    sql: ${TABLE}.FacilityAcademicMedCtr ;;
  }

  dimension: facility_affiliated_med_school {
    label: "Affiliated School"
    type: string
    sql: ${TABLE}.FacilityAffiliatedMedSchool ;;
  }

  dimension: facility_yacode {
    type: string
    sql: ${TABLE}.FacilityYACode ;;
  }

  dimension: facility_account_type {
    label: "BP Account Type"
    type: string
    sql: ${TABLE}.FacilityAccountType ;;
  }

  dimension: facility_bpreporting_group {
    label: "BP Reporting Group"
    type: string
    sql: ${TABLE}.FacilityBPReportingGroup ;;
  }

  dimension: facility_bpparent_only {
    type: number
    sql: ${TABLE}.FacilityBPParentOnly ;;
  }

  dimension: zip_code {
    type: string
    sql: ${TABLE}.ZipCode ;;
  }

  dimension: trauma_center {
    type: string
    sql: ${TABLE}.TraumaCenter ;;
  }

  dimension: teaching_hospital {
    type: string
    sql: ${TABLE}.TeachingHospital ;;
  }

  dimension: filename {
    type: string
    sql: ${TABLE}.Filename ;;
  }

  dimension: folder_name {
    type: string
    sql: ${TABLE}.FolderName ;;
  }

  dimension: icon {
    type: string
    sql: ${TABLE}.Icon ;;
  }

  dimension: bp_demo {
    type: number
    sql: ${TABLE}.IsDemo ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      facility_skey,
      facility_name,
      facility_owner,
      facility_benchmark_code,
      facility_direct_parent,
      facility_entity_code,
      entity_top_parent,
      facility_state,
      facility_region,
      facility_custom_region,
      facility_patient_volume,
      facility_beds,
      facility_size,
      facility_academic_med_ctr,
      facility_affiliated_med_school,
      facility_yacode,
      facility_account_type,
      facility_bpreporting_group,
      facility_bpparent_only,
      zip_code,
      trauma_center,
      teaching_hospital,
      filename,
      folder_name,
      icon
    ]
  }

  set: facility_exclusions{
    fields: [
      facility_skey
      ,filename
      ,folder_name
      ,icon
      ,entity_top_parent
      ,facility_direct_parent
      ,facility_entity_code
      ,facility_owner
      ,facility_yacode
      ,facility_patient_volume
      ,facility_beds
      ,facility_size
      ,facility_bpparent_only
    ]
  }

  set: enduser{
    fields: [
      facility_name,
      facility_benchmark_code,
      facility_state,
      facility_region,
      facility_custom_region,
      facility_patient_volume,
    ]
  }
}
