near_geo <- function(lat, long, miles, type) {
    widget_builder(
        table = "d_bio_address_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = list(
            quote(latitude %is not% null),
            quote(longitude %is not% null),
            pryr::subs(sdo_geom.sdo_distance(
                sdo_geometry(2001L, 8307L, sdo_point_type(longitude, latitude, NULL), NULL, NULL),
                sdo_geometry(2001L, 8307L, sdo_point_type(long, lat, NULL), NULL, NULL),
                1, 'unit=Mile'
            ) < miles)
        )
    )
}


    # select
    # entity_id, latitude, longitude,
    # addr_type_desc, street1, city, state_code,
    # sdo_geometry(2001, 8307, sdo_point_type(longitude, latitude, NULL), NULL, NULL) as pnt,
    # sdo_geometry(2001, 8307, sdo_point_type(-122.2542, 37.87238, NULL), NULL, NULL) as pnt2,
    # sdo_geom.sdo_distance(
    #     sdo_geometry(2001, 8307, sdo_point_type(longitude, latitude, NULL), NULL, NULL),
    #     sdo_geometry(2001, 8307, sdo_point_type(-122.2542, 37.87238, NULL), NULL, NULL),
    #     1,
    #     'unit=Mile'
    # ) as dist
    # from cdw.d_bio_address_mv
    # where latitude is not null and longitude is not null and
    # sdo_geom.sdo_distance(
    #     sdo_geometry(2001, 8307, sdo_point_type(longitude, latitude, NULL), NULL, NULL),
    #     sdo_geometry(2001, 8307, sdo_point_type(-122.2542, 37.87238, NULL), NULL, NULL),
    #     1,
    #     'unit=Mile'
    # ) < 5

}
