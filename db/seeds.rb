# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Added by Refinery CMS Pages extension
# Refinery::Pages::Engine.load_seed  # Commented out in order to seed my own data

# Create image in order to be able to load in a page later
#moneda_social_path = "#{Rails.root.join('app/assets/images/monedasociallogo.png')}"
#image_moneda_social= Refinery::Image.create :image => File.new(moneda_social_path)

# Create one single user in order to avoid entering a user in development mode
if Rails.env.development?
  admin_user = Refinery::Authentication::Devise::User.create!( :username => 'test',
                                                :email => "test@test.com", 
                                                :password => 'test')

  # Add necessary roles
  # https://groups.google.com/d/msg/refinery-cms/akI74wnviFs/j613apqJdvgJ
  admin_user.add_role :refinery
  admin_user.add_role :superuser
end

# Added by Refinery CMS Image Slides extension
Refinery::ImageSlideshows::Engine.load_seed

# Path to some images used in pages
espai_path = "#{Rails.root.join('app/assets/images/cafeteria/espai.jpg')}"
cistell_pan_path = "#{Rails.root.join('app/assets/images/pan/cistell.jpg')}"
cursos_cartell_path = "#{Rails.root.join('app/assets/images/cursos/cursos_cartell.jpg')}"

# Images used in pages
image_espai= Refinery::Image.create :image => File.new(espai_path)
image_cistell_pan = Refinery::Image.create :image => File.new(cistell_pan_path)
image_cursos_cartell = Refinery::Image.create :image => File.new(cursos_cartell_path)

# Path to images in SLIDE SHOW IN HOME PAGE
obrador_reposteria_path = "#{Rails.root.join('app/assets/images/obrador/reposteria1000x400.jpg')}"
cafeteria_path = "#{Rails.root.join('app/assets/images/cafeteria/cafeteria1000x400.jpg')}"
croi_path = "#{Rails.root.join('app/assets/images/reposteria/croi1000x400.jpg')}"
panes_path = "#{Rails.root.join('app/assets/images/buenas/panes.jpg')}"

# Images in SLIDE SHOW IN HOME PAGE
image_obrador_reposteria= Refinery::Image.create :image => File.new(obrador_reposteria_path)
image_cafeteria= Refinery::Image.create :image => File.new(cafeteria_path)
image_croi= Refinery::Image.create :image => File.new(croi_path)
image_panes= Refinery::Image.create :image => File.new(panes_path)

slide_images = [
  {
    :title => "Reposteria", 
    :image_id => image_obrador_reposteria.id 
  },
  {
    :title => "Cafeteria", 
    :image_id => image_cafeteria.id 
  },
  {
    :title => "Croi", 
    :image_id => image_croi.id 
  },
  # {
  #   :title => "Panes", 
  #   :image_id => image_panes.id 
  # }
]

#binding.pry

slide_images.each do | slide_image |

  refinery_image_slide = Refinery::ImageSlideshows::ImageSlide.create!( 
    :title => slide_image[:title], 
    :image_id => slide_image[:image_id] )

  refinery_image_slide.translations.create!( :locale => :ca, :title => slide_image[:title] )
end

slider = Refinery::ImageSlideshows::ImageSlideshow.create!( :title => "Home Page Slide Show")
slider.image_slides = Refinery::ImageSlideshows::ImageSlide.all.to_a

pages_array = [ {
                    :show_in_menu => true,
                    :deletable => false,
                    :link_url => "/",
                    :menu_match => "^/$",
                    :title => "Home",  # default english title
                    :title_es => "Inicio",
                    :title_ca => "Inici",
                    # Image path in next line is copied from the ui when I try to add it manually
                    :body => "
                    <div class=\"row\">
                    <div class=\"large-12 columns\">
                      <div class=\"panel\">
                        <h4>Organic hand made bread in la Garrotxa!</h4>
                        <div class=\"row\">
                          <div class=\"large-9 columns\">
                            <p>Come and visit our cafeteria.</p>
                          </div>
                          <div class=\"large-3 columns\">
                            <a href=\"contacte\" class=\"radius button right\"><i class=\"fi-marker\"> We are here!</i></a>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                    <p>La Fogaina is a project that .... autogestionat, familiar i ara SI un somni fet realitat... A l'obrador tenim molta cura amb la qualitat final del producte, a la botigueta tenim molta cura de mantenir el tracte amable i sincer amb els visitants. Això ho aconseguim amb:
Prioritzant les farines de molí de pedra de Sales de Llierca d'en Victor de Triticatum, on bàsicament es treballa amb varietats de blats indígenes, con el Xeixa, el forment, el bompany, montcada, blat del cor i d'altres, totes ecològiques i moltes d'elles locals. Les altres farines que utilitzem son de Moulin de Colagne, molí medieval de pedra que treballa amb farines ecològiques de gran qualitat.</p>
                    <div class=\"row\">
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Project</h4>
                      <p>La Fogaina és un petit projecte autogestionat, familiar i ara SI un somni fet realitat... A l'obrador tenim molta cura amb la qualitat final del producte, a la botigueta tenim molta cura de mantenir el tracte amable i sincer amb els visitants. Això ho aconseguim amb:
Prioritzant les farines de molí de pedra de Sales de Llierca d'en Victor de Triticatum, on bàsicament es treballa amb varietats de blats indígenes, con el Xeixa, el forment, el bompany, montcada, blat del cor i d'altres, totes ecològiques i moltes d'elles locals.</p>
                    </div>
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Cafeteria</h4>
                      <p>Desde la Fogaina voliem oferir un servei d'entrega dels nostres productes pels nostres clients de la vall d'en bas i olot, i finalment hem trobat la manera més acord amb la nostra filosofia de sostenibilitat i manera de fer, i és treballar al costat d' Oclot un servei de missatgeria a domicili ecològic (en bicicleta!!).
                      Volem donar la millor qualitat dels nostres productes des d'el forn fins a la porta de casa.
A partir d'ara ja podeu fer les vostres comandes a la pàgina web de OCLOT o trucant directament al telèfon de la nostra botiga: 646 879 062
</p>
                    </div>
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Courses</h4>
                      <p>Si voleu apuntar-vos a la nostra llista de mail, per estar informats dels cursos que anem programant, envieu un mail a: fornlafogaina@gmail.com , i ens expliqueu el motiu.
Normalment les places pels cursos son màxim de 7 persones, per poder gaudir de l'espai i de l'aprenentatge. Tots el cursos es poden pagar amb moneda social.</p>
                    </div>
                  </div>" % [image_cistell_pan.url, image_espai.url, image_cursos_cartell.url],
                    :body_es => "
                    <div class=\"row\">
                    <div class=\"large-12 columns\">
                      <div class=\"panel\">
                        <h4>Pan artesano i ecológico en la Garrotxa!</h4>
                        <div class=\"row\">
                          <div class=\"large-9 columns\">
                            <p>Ven a ver nuestra cafeteria.</p>
                          </div>
                          <div class=\"large-3 columns\">
                            <a href=\"contacte\" class=\"radius button right\"><i class=\"fi-marker\"> Estamos aquí!</i></a>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                    <p>La Fogaina es un proyecto .... autogestionat, familiar i ara SI un somni fet realitat... A l'obrador tenim molta cura amb la qualitat final del producte, a la botigueta tenim molta cura de mantenir el tracte amable i sincer amb els visitants. Això ho aconseguim amb:
Prioritzant les farines de molí de pedra de Sales de Llierca d'en Victor de Triticatum, on bàsicament es treballa amb varietats de blats indígenes, con el Xeixa, el forment, el bompany, montcada, blat del cor i d'altres, totes ecològiques i moltes d'elles locals. Les altres farines que utilitzem son de Moulin de Colagne, molí medieval de pedra que treballa amb farines ecològiques de gran qualitat.</p>
                    <div class=\"row\">
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Proyecto</h4>
                      <p>La Fogaina és un petit projecte autogestionat, familiar i ara SI un somni fet realitat... A l'obrador tenim molta cura amb la qualitat final del producte, a la botigueta tenim molta cura de mantenir el tracte amable i sincer amb els visitants. Això ho aconseguim amb:
Prioritzant les farines de molí de pedra de Sales de Llierca d'en Victor de Triticatum, on bàsicament es treballa amb varietats de blats indígenes, con el Xeixa, el forment, el bompany, montcada, blat del cor i d'altres, totes ecològiques i moltes d'elles locals.</p>
                    </div>
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Cafeteria</h4>
                      <p>Desde la Fogaina voliem oferir un servei d'entrega dels nostres productes pels nostres clients de la vall d'en bas i olot, i finalment hem trobat la manera més acord amb la nostra filosofia de sostenibilitat i manera de fer, i és treballar al costat d' Oclot un servei de missatgeria a domicili ecològic (en bicicleta!!).
                      Volem donar la millor qualitat dels nostres productes des d'el forn fins a la porta de casa.
A partir d'ara ja podeu fer les vostres comandes a la pàgina web de OCLOT o trucant directament al telèfon de la nostra botiga: 646 879 062
</p>
                    </div>
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Cursos</h4>
                      <p>Si voleu apuntar-vos a la nostra llista de mail, per estar informats dels cursos que anem programant, envieu un mail a: fornlafogaina@gmail.com , i ens expliqueu el motiu.
Normalment les places pels cursos son màxim de 7 persones, per poder gaudir de l'espai i de l'aprenentatge. Tots el cursos es poden pagar amb moneda social.</p>
                    </div>
                  </div>" % [image_cistell_pan.url, image_espai.url, image_cursos_cartell.url],
                    :body_ca => "
                    <div class=\"row\">
                    <div class=\"large-12 columns\">
                      <div class=\"panel\">
                        <h4>Pa artesà i ecològic a la Garrotxa!</h4>
                        <div class=\"row\">
                          <div class=\"large-9 columns\">
                            <p>Vine a veure la nostra cafeteria.</p>
                          </div>
                          <div class=\"large-3 columns\">
                            <a href=\"contacte\" class=\"radius button right\"><i class=\"fi-marker\"> Estem aquí!</i></a>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                    <p>La Fogaina es un projecte autogestionat, familiar i ara SI un somni fet realitat... A l'obrador tenim molta cura amb la qualitat final del producte, a la botigueta tenim molta cura de mantenir el tracte amable i sincer amb els visitants. Això ho aconseguim amb:
Prioritzant les farines de molí de pedra de Sales de Llierca d'en Victor de Triticatum, on bàsicament es treballa amb varietats de blats indígenes, con el Xeixa, el forment, el bompany, montcada, blat del cor i d'altres, totes ecològiques i moltes d'elles locals. Les altres farines que utilitzem son de Moulin de Colagne, molí medieval de pedra que treballa amb farines ecològiques de gran qualitat.</p>
                    <div class=\"row\">
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Projecte</h4>
                      <p>La Fogaina és un petit projecte autogestionat, familiar i ara SI un somni fet realitat... A l'obrador tenim molta cura amb la qualitat final del producte, a la botigueta tenim molta cura de mantenir el tracte amable i sincer amb els visitants. Això ho aconseguim amb:
Prioritzant les farines de molí de pedra de Sales de Llierca d'en Victor de Triticatum, on bàsicament es treballa amb varietats de blats indígenes, con el Xeixa, el forment, el bompany, montcada, blat del cor i d'altres, totes ecològiques i moltes d'elles locals.</p>
                    </div>
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Cafeteria</h4>
                      <p>Desde la Fogaina voliem oferir un servei d'entrega dels nostres productes pels nostres clients de la vall d'en bas i olot, i finalment hem trobat la manera més acord amb la nostra filosofia de sostenibilitat i manera de fer, i és treballar al costat d' Oclot un servei de missatgeria a domicili ecològic (en bicicleta!!).
                      Volem donar la millor qualitat dels nostres productes des d'el forn fins a la porta de casa.
A partir d'ara ja podeu fer les vostres comandes a la pàgina web de OCLOT o trucant directament al telèfon de la nostra botiga: 646 879 062
</p>
                    </div>
                    <div class=\"large-4 columns\">
                      <img src=\"%s\">
                      <h4>Cursos</h4>
                      <p>Si voleu apuntar-vos a la nostra llista de mail, per estar informats dels cursos que anem programant, envieu un mail a: fornlafogaina@gmail.com , i ens expliqueu el motiu.
Normalment les places pels cursos son màxim de 7 persones, per poder gaudir de l'espai i de l'aprenentatge. Tots el cursos es poden pagar amb moneda social.</p>
                    </div>
                  </div>" % [image_cistell_pan.url, image_espai.url, image_cursos_cartell.url],    
                    :side_body => "", 
                    :side_body_es => "",
                    :side_body_ca => "",                  
                    #:position_side_body => 0,
                    #:banner => banner_html[:default],
                    #:banner_es => banner_html[:es],
                    #:banner_ca => banner_html[:ca],
                    #:position_banner => 0,
                    :position_body => 1,
                    :children =>  {
                        :show_in_menu => false,
                        :deletable => false,
                        :menu_match => "^/404$",
                        :title => "Pagina no trobada",
                        :title_es => "Página no encontrada",
                        :title_ca => "Pàgina no trobada",
                        :position_body => 0,
                        :body => "<h4>Upsss! Sorry, there has been a problem ...</h4><p>The page is not available.</p><p><a href='/'>Back to home</a></p>",
                        :body_es => "<h4>Upsss! Lo sentimos, ha habido un problema ...</h4><p>La página solicitada no ha sido encontrada.</p><p><a href='/es'>Vuelva a la página de inicio</a></p>",
                        :body_ca => "<h4>Upsss! Ho sentim, hi ha hagut un problema ...</h4><p>La pàgina sol-licitada no s'ha trobat.</p><p><a href='/ca'>Tornar a la pàgina de inici</a></p>",
                    }
                },
                {
                    :show_in_menu => true,
                    :deletable => true,
                    :title => "Bread and Coffee",
                    :title_es => "Pan i Café",
                    :title_ca => "Pa i Cafè",
                    :body => "<p>This is the body of Bread and coffee.</p>",
                    :body_es => "<p>Esto es el body de Pan i Cafe.</p>",
                    :body_ca => "<p>Això es el body de pa i cafe</p>",
                    :side_body => "<p>This is the side body of Bread and Coffee.</p>", 
                    :side_body_es => "<p>Esto es el side body de Pan in Cafe.</p>",
                    :side_body_ca => "<p>Això es el side body de Pa i Cafe</p>", 
                },
                {
                    :show_in_menu => true,
                    :deletable => true,
                    :title => "Wanna know more?",
                    :title_es => "Quieres saber mas?",
                    :title_ca => "Vols saber més?",
                    :body => "<p>This is the body of Wanna know more?",
                    :body_es => "<p>Esto es el body de Quieres saber mas</p>",
                    :body_ca => "<p>Això es el body de Vols saber mes?</p>",
                    :side_body => "<p>This is the side body of Wanna know more?</p>", 
                    :side_body_es => "<p>Esto es el side body de Quieres saber mas?</p>",
                    :side_body_ca => "<p>Això es el side body de Vols saber mes?</p>",
                    :children =>  {
                        :show_in_menu => true,
                        :deletable => true,
                        :title => "Courses",
                        :title_es => "Cursos",
                        :title_ca => "Cursos",
                        :body => "<p>Coming soon ...</p><p><a href='/'>Back to home</a></p>",
                        :body_es => "<p>Proximamente ...</p><p><a href='/'>Volver al inicio</a></p>",
                        :body_ca => "<p>Proximament ...</p><p><a href='/'>Tornar a l'inici</a></p>"
                    }
                },
                {
                    :show_in_menu => true,
                    :deletable => true,
                    :title => "Contact",  # default german title
                    :title_es => "Contacto",
                    :title_ca => "Contacte",
                    :body => "<div class=\"row\">
                                <div class=\"large-12 columns\">
                                  <div class=\"large-4 columns\">
                                    <div class=\"panel\">
                                      <h4>La Fogaina</h4>
                                      <p>Saturday from 9:30h until 13:30h </p>
                                      <p><i class=\"fi-marker\"> Mas la Plana s/n, El Mallol, Carretera del Veïnat Cirera. La Vall d'en Bas, Girona</i><br><i class=\"fi-telephone\"> 661 38 09 55</i> / <i class=\"fi-telephone\"> 639 26 48 63</i></p>
                                    </div>
                                    <div class=\"panel\">
                                      <h4>La Fogaina Pa i Cafè.</h4>
                                      <p>Tuesday to Saturday from 8:00h until 13:30h and from 16:00h until 20:00h</p>
                                      <p><i class=\"fi-marker\"> c/ Sant Sebastià nº52, Les Preses, Girona</i><br><i class=\"fi-telephone\"> 646 87 90 62</i></p>
                                    </div>
                                  </div>
                                  <div class=\"large-8 columns\">
                                    <div id=\"map-fogaina\"></div>
                                  </div>
                                </div>
                              </div>",
                    :body_es => "<div class=\"row\">
                                <div class=\"large-12 columns\">
                                  <div class=\"large-4 columns\">
                                    <div class=\"panel\">
                                      <h4>La Fogaina</h4>
                                      <p>Sábados de 9:30h a 13:30h </p>
                                      <p><i class=\"fi-marker\"> Mas la Plana s/n, El Mallol, Carretera del Veïnat Cirera. La Vall d'en Bas, Girona</i><br><i class=\"fi-telephone\"> 661 38 09 55</i> / <i class=\"fi-telephone\"> 639 26 48 63</i></p>
                                    </div>
                                    <div class=\"panel\">
                                      <h4>La Fogaina Pa i Cafè.</h4>
                                      <p>De Martes a Sábado de 8:00h a 13:30h i de 16:00h a 20:00h</p>
                                      <p><i class=\"fi-marker\"> c/ Sant Sebastià nº52, Les Preses, Girona</i><br><i class=\"fi-telephone\"> 646 87 90 62</i></p>
                                    </div>
                                  </div>
                                  <div class=\"large-8 columns\">
                                    <div id=\"map-fogaina\"></div>
                                  </div>
                                </div>
                              </div>",
                    :body_ca => "<div class=\"row\">
                                <div class=\"large-12 columns\">
                                  <div class=\"large-4 columns\">
                                    <div class=\"panel\">
                                      <h4>La Fogaina</h4>
                                      <p>Dissabtes de 9:30h a 13:30h </p>
                                      <p><i class=\"fi-marker\"> Mas la Plana s/n, El Mallol, Carretera del Veïnat Cirera. La Vall d'en Bas, Girona</i><br><i class=\"fi-telephone\"> 661 38 09 55</i> / <i class=\"fi-telephone\"> 639 26 48 63</i></p>
                                    </div>
                                    <div class=\"panel\">
                                      <h4>La Fogaina Pa i Cafè.</h4>
                                      <p>De Dimarts a Dissabte de 8:00h a 13:30h i de 16:00h a 20:00h</p>
                                      <p><i class=\"fi-marker\"> c/ Sant Sebastià nº52, Les Preses, Girona</i><br><i class=\"fi-telephone\"> 646 87 90 62</i></p>
                                    </div>
                                  </div>
                                  <div class=\"large-8 columns\">
                                    <div id=\"map-fogaina\"></div>
                                  </div>
                                </div>
                              </div>"
                }
]

def finnish_page( page, page_attr )
  page.translations.create!( { :locale => 'es', :title => page_attr[:title_es] } )
  page.translations.create!( { :locale => 'ca', :title => page_attr[:title_ca] } )

  page_body_part = page.parts.create!( { :title => "Body", :body => page_attr[:body], :position => page_attr[:position_body] } )

  page_body_part.translations.create!( { :locale => "es", :body => page_attr[:body_es] } )
  page_body_part.translations.create!( { :locale => "ca", :body => page_attr[:body_ca] } )

  if page_attr.has_key?(:banner)

    page_banner_part = page.parts.create!( { :title => "Banner", :body => page_attr[:banner], :position => page_attr[:position_banner] } )

    page_banner_part.translations.create!( { :locale => "es", :body => page_attr[:banner_es] } )
    page_banner_part.translations.create!( { :locale => "ca", :body => page_attr[:banner_ca] } )

  end

  if page_attr.has_key?(:side_body)

    page_side_body_part = page.parts.create!( { :title => "Side Body", :body => page_attr[:side_body], :position => page_attr[:position_side_body] } )

    page_side_body_part.translations.create!( { :locale => "es", :body => page_attr[:side_body_es] } )
    page_side_body_part.translations.create!( { :locale => "ca", :body => page_attr[:side_body_ca] } )

  end

  if page_attr.has_key?(:children)

    children_attr = page_attr[:children]

    page_children = page.children.create!( :title => children_attr[:title],
                                           :menu_match => children_attr[:menu_match],
                                           :show_in_menu => children_attr[:show_in_menu],
                                           :deletable => children_attr[:deletable] )

    page_children.translations.create!( { :locale => "es", :title => children_attr[:title_es] } )
    page_children.translations.create!( { :locale => "ca", :title => children_attr[:title_ca] } )

    page_children_body_part = page_children.parts.create!( { :title => "Body", :body => children_attr[:body], :position => children_attr[:position_body] } )

    page_children_body_part.translations.create!( { :locale => "es", :body => children_attr[:body_es] } )
    page_children_body_part.translations.create!( { :locale => "ca", :body => children_attr[:body_ca] } )
  end
end


# Start here ...
pages_array.each { | page_attr |

  page_is_root = page_attr.has_key?(:menu_match) && page_attr.has_key?(:link_url) && page_attr.has_key?(:position_body)

  # Call page constructor based on the attributes available
  page = ( page_is_root ) ?
      # Just for the root page
      Refinery::Page.create!( { :show_in_menu => page_attr[:show_in_menu],
                                :deletable => page_attr[:deletable],
                                :link_url => page_attr[:link_url],
                                :menu_match => page_attr[:menu_match],
                                :title => page_attr[:title] } ) :
      # For the rest of pages
      Refinery::Page.create!( { :show_in_menu => page_attr[:show_in_menu],
                                :deletable => page_attr[:deletable],
                                :title => page_attr[:title] } )

  finnish_page( page, page_attr )
}


# Path to images PAN
soques_path = "#{Rails.root.join('app/assets/images/pan/soques.jpg')}"
soca_path = "#{Rails.root.join('app/assets/images/pan/soca.jpg')}"
pa_pages_path = "#{Rails.root.join('app/assets/images/pan/pa_de_pages.jpg')}"
pa_rustic_path = "#{Rails.root.join('app/assets/images/pan/rustic.jpg')}"
pa_croscat_espelta_path = "#{Rails.root.join('app/assets/images/pan/croscat_espelta.jpg')}"
coca_forner_path = "#{Rails.root.join('app/assets/images/pan/coca_forner.jpg')}"
pa_de_coca_path = "#{Rails.root.join('app/assets/images/pan/pa_de_coca.jpg')}"
pa_brot_negre_path = "#{Rails.root.join('app/assets/images/pan/brot_negre.jpg')}"
pa_bembo_path = "#{Rails.root.join('app/assets/images/pan/bembo.jpg')}"
pa_sense_gluten_path = "#{Rails.root.join('app/assets/images/pan/pa_sense_gluten.jpg')}"
pa_segol_path = "#{Rails.root.join('app/assets/images/pan/segol.jpg')}"
pa_baguette_path = "#{Rails.root.join('app/assets/images/pan/baguette.jpg')}"
pa_de_farro_path = "#{Rails.root.join('app/assets/images/pan/pa_de_farro.jpg')}"

# Images PAN
image_soques = Refinery::Image.create :image => File.new(soques_path)
image_soca = Refinery::Image.create :image => File.new(soca_path)
image_pa_de_pages = Refinery::Image.create :image => File.new(pa_pages_path)
image_pa_rustic = Refinery::Image.create :image => File.new(pa_rustic_path)
image_pa_croscat_espelta = Refinery::Image.create :image => File.new(pa_croscat_espelta_path)
image_coca_forner = Refinery::Image.create :image => File.new(coca_forner_path)
image_pa_de_coca = Refinery::Image.create :image => File.new(pa_de_coca_path)
image_brot_negre = Refinery::Image.create :image => File.new(pa_brot_negre_path)
image_pa_bembo = Refinery::Image.create :image => File.new(pa_bembo_path)
image_pa_sense_gluten = Refinery::Image.create :image => File.new(pa_sense_gluten_path)
image_pa_segol = Refinery::Image.create :image => File.new(pa_segol_path)
image_pa_baguette = Refinery::Image.create :image => File.new(pa_baguette_path)
image_pa_de_farro = Refinery::Image.create :image => File.new(pa_de_farro_path)

# Added by Refinery CMS Breads extension
Refinery::Breads::Engine.load_seed

breads_page = Refinery::Page.find_by(:menu_match => "^/breads.*$")

raise "Error, there should be a breads page! See seeds.rb" if breads_page == nil

breads_page.translations.create!( { :locale => "es", :title => "Nuestros Panes" } )
breads_page.translations.create!( { :locale => "ca", :title => "Els nostres pans" } )

panes = [ 
          { 
            :name_ca => "La Soca", 
            :name_es => "La Soca",
            :name_en => "La Soca",  
            :description_ca => "Pa integral de motlle amb cereals i llavors. Aquest pa és el millor per a fer torrades contundents i acompanyar qualsevol menjar.<br>
                                Pa de llarga fermentació. El podriem considerar un multicereals, amb una farina de molí de pedra i de primera qualitat (blat del cor, xeixa, montcada,espelta...). Tot això fa un pa gustosíssim. Baix en gluten.",
            :description_es => "Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.",
            :description_en => "Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.",
            :available_days => [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday],
            :price => nil,
            :photo => image_soca
          },
          { :name_ca => "Pa de pagés", 
            :name_es => "Pan de pagés",
            :name_en => "Pa de pagés",  
            :description_ca => "Pa rodó amb farina blanca ecològica. Massa mare i una mica de llevat. Es el pa de tota la vida però amb caràcter i molt de gust. Pels que no volen renunciar a fer un pa amb tomàquet o sucar a salses i ous ferrats ...",
            :description_es => "Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.",
            :description_en => "Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.",
            :available_days => [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday],
            :price => nil,
            :photo => image_pa_de_pages
          },
          { :name_ca => "Rústic", 
            :name_es => "Rústico",
            :name_en => "Rustic",  
            :description_ca => "Pa amb forma de batard, amb farina blanca ecològica, i una mica de farina sègol i blat integral. Massa mare. Es un pa amb una fermentació retardada i molt lenta, que fa que tingui un gust pronunciat a cereals, crosta rústica i molla cremosa.",
            :description_es => "Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.",
            :description_en => "Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.",
            :available_days => [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday],
            :price => 3,
            :photo => image_pa_rustic
          },
          { :name_ca => "Tinosell", 
            :name_es => "Tinosell",
            :name_en => "Tinosell",  
            :description_ca => "Mateixa massa del Rústic però amb deliciosos trocets de panses nous i albercoc. Format Motllo. Només massa mare.",
            :description_es => "Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.",
            :description_en => "Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.",
            :available_days => [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday],
            :price => 4,
            :photo => nil 
          },
          { :name_ca => "Croscat Espelta", 
            :name_es => "Croscat Espelta",
            :name_en => "Croscat Espelta",  
            :description_ca => "Panet rodó d'espelta amb semilles de girasol i sèsam. Només farina integral i semiintegral d'espelta molta amb molí de pedra. Massa mare d'espelta.",
            :description_es => "Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.",
            :description_en => "Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.",
            :available_days => [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday],
            :price => 4.30,
            :photo => image_pa_croscat_espelta 
          },
          { :name_ca => "Coca de forner", 
            :name_es => "Coca de forner",
            :name_en => "Coca de forner",  
            :description_ca => "Coca de oli d'oliva, sucre i anís. Bona alveolatura, tendra i caramelitzada a toc de foc.",
            :description_es => "Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.",
            :description_en => "Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.",
            :available_days => [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday],
            :price => 3.10,
            :photo => image_coca_forner 
          },
          { :name_ca => "Pa de coca", 
            :name_es => "Pa de coca",
            :name_en => "Pa de coca",  
            :description_ca => "Aqui trobareu el millor amic per fer unes torrades amb pa amb tomàquet 
                                iniigual.lables. Cuït amb flama directa.",
            :description_es => "Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.",
            :description_en => "Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.",
            :available_days => [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday],
            :price => 2.60,
            :photo => image_pa_de_coca 
          },
          { :name_ca => "Brot Negre", 
            :name_es => "Brot Negre",
            :name_en => "Brot Negre",  
            :description_ca => "Pa de segle de motlle petit. 100%  de ségol integral. Molt molt aromàtic. 
                                Es pot combinar amb aliments de gustos forts i contrastats. Però si ets un amant del segle, te'l menjaràs sol!!
                                El sègol es un cereal del qual obtenim una farina mol baixa en gluten. ",
            :description_es => "Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.",
            :description_en => "Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.",
            :available_days => :no_mostrar,
            :price => nil,
            :photo => image_brot_negre 
          },
          { :name_ca => "Bembó", 
            :name_es => "Bembó",
            :name_en => "Bembó",  
            :description_ca => "Pa de motllo blanc típic per fer 'bikinis' o torrades dolces. Un pa molt tendre, suau però amb una miga més sabrosa que les industrials, gracies a l'elaboració amb massa mare. Porta sucre moré panela, mantega i llet ecològica.",
            :description_es => "Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.",
            :description_en => "Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.",
            :available_days => [:wednesday, :thursday],
            :price => 4,
            :photo => image_pa_bembo 
          },
          { :name_ca => "Pa sense gluten", 
            :name_es => "Pan sin gluten",
            :name_en => "Bread gluten-free",  
            :description_ca => "Davant de tanta demanda ens animem a fer aquest pa sense gluten (*pot contenir traces, no apte per celíacs), amb farines ecológiques i moltes a la pedra de Fajol (blat sarraí), Arrós Integral i Cigró. També amb midó de tapioca i Maicena Ecológica. Per donar més sabor li possem llavors de chia, llí i sésam. El format es en motllo i intentem, encara que no te gluten, aconseguir una textura i estructura suau i esponjosa. Un pa molt saludable per tothom.",
            :description_es => "Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.",
            :description_en => "Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.",
            :available_days => :por_encargo,
            :price => 6,
            :photo => image_pa_sense_gluten 
          },
          { :name_ca => "Ségol - Blat amb panses i nous", 
            :name_es => "Ségol - Blat amb panses i nous",
            :name_en => "Ségol - Blat amb panses i nous",  
            :description_ca => "Un pa de farina semi integral de blat, amb molta molta massa mare de ségol. 
                                Acompanyat amb panses i nous en quantitat. Un pa molt aromàtic i de bona conservació. Un plaer acompanyant tant formatges i fumats com mermelades.",
            :description_es => "Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.",
            :description_en => "Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.",
            :available_days => [:friday],
            :price => 3.80,
            :photo => image_pa_segol 
          },
          { :name_ca => "Baguette", 
            :name_es => "Baguette",
            :name_en => "Baguette",  
            :description_ca => "Baguettes amb formula de tradició francesa, amb farines de blat moltes a la pedra, massa mare i llevat. Fermentacions llargues i cuita al forn de llenya.
                                Per fi gaudim de les barres a la Fogaina.",
            :description_es => "Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.",
            :description_en => "Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.",
            :available_days => [:wednesday, :friday, :saturday],
            :price => 1.70,
            :photo => image_pa_baguette 
          },
          { :name_ca => "Pa de Farro", 
            :name_es => "Pa de Farro",
            :name_en => "Pa de Farro",  
            :description_ca => "El Farro (blat de moro) es un producte típic de la Vall d'en Bas, una vall fertil pel 
                                cultiu d'aquest cereal. Malauradament avui dia es dificil de trobar Farro de varietats locals i ecológic, per desgracia els trangénics van guanyant terreny. Ara mateix estem utilitzant Farro de la Vall de Bianya de varietat local.
                                Es un pa suau i fi, un punt dolcet, una miga amb un color crema grogenc que fa contrast amb una crosta deliciosa de color daurat. Tasteu!!",
            :description_es => "Perdona, estamos traduciendo nuestro contenido. Por favor, utiliza nuestra web en catalan mientras tanto. Gracias.",
            :description_en => "Sorry, we are still translating our content. Please use our catalan translations until we finnish them. Thanks.",
            :available_days => :por_encargo,
            :price => 2.70,
            :photo => image_pa_de_farro 
          }
        ]

panes.each do |pan_attr|
  pan = Refinery::Breads::Bread.create!( :name => pan_attr[:name_en], 
                                         :description => pan_attr[:description_en],
                                         :available_days => pan_attr[:available_days],
                                         :price => pan_attr[:price],
                                         :photo => pan_attr[:photo],
                                         :locale => "en" )

  pan.translations.create!( :refinery_bread_id => pan.id,
                            :locale => "ca",
                            :name => pan_attr[:name_ca],
                            :description => pan_attr[:description_ca] )

  pan.translations.create!( :refinery_bread_id => pan.id,
                            :locale => "es",
                            :name => pan_attr[:name_es],
                            :description => pan_attr[:description_es] )

end
# Added by Refinery CMS News engine
Refinery::News::Engine.load_seed


news_page = Refinery::Page.find_by(:menu_match => "^/news.*$")

raise "Error, there should be a news page! See seeds.rb" if news_page == nil

news_page.translations.create!( { :locale => "es", :title => "Noticias" } )
news_page.translations.create!( { :locale => "ca", :title => "Notícies" } )

noticias = [ 
  {
    title_ca: "La Fogaina-Oclot. Servei d'entrega ecològic", 
    title_en: "La Fogaina-Oclot. Organic delivery system.",
    title_es: "La Fogaina-Oclot. Servicio de entrega ecológico.",  
    body_ca: "Desde la Fogaina voliem oferir un servei d'entrega dels nostres productes pels nostres clients de la vall d'en bas i olot, i finalment hem trobat la manera més acord amb la nostra filosofia de sostenibilitat i manera de fer, i és treballar al costat d' Oclot un servei de missatgeria a domicili ecològic (en bicicleta!!).
           Volem donar la millor qualitat dels nostres productes des d'el forn fins a la porta de casa.
           A partir d'ara ja podeu fer les vostres comandes a la pàgina web de OCLOT o trucant directament al telèfon de la nostra botiga: 646.879.062
           Salut, Pa i Pedals!!!", 
    body_en: "Desde la Fogaina voliem oferir un servei d'entrega dels nostres productes pels nostres clients de la vall d'en bas i olot, i finalment hem trobat la manera més acord amb la nostra filosofia de sostenibilitat i manera de fer, i és treballar al costat d' Oclot un servei de missatgeria a domicili ecològic (en bicicleta!!).
           Volem donar la millor qualitat dels nostres productes des d'el forn fins a la porta de casa.
           A partir d'ara ja podeu fer les vostres comandes a la pàgina web de OCLOT o trucant directament al telèfon de la nostra botiga: 646.879.062
           Salut, Pa i Pedals!!!",
    body_es: "Desde la Fogaina voliem oferir un servei d'entrega dels nostres productes pels nostres clients de la vall d'en bas i olot, i finalment hem trobat la manera més acord amb la nostra filosofia de sostenibilitat i manera de fer, i és treballar al costat d' Oclot un servei de missatgeria a domicili ecològic (en bicicleta!!).
           Volem donar la millor qualitat dels nostres productes des d'el forn fins a la porta de casa.
           A partir d'ara ja podeu fer les vostres comandes a la pàgina web de OCLOT o trucant directament al telèfon de la nostra botiga: 646.879.062
           Salut, Pa i Pedals!!!",
    publish_date: DateTime.now  
  },
  {
    title_ca: "Cursos de pa a la Fogaina febrer-abril 2015",
    title_en: "Bread Courses at la Fogaina february-april 2015",
    title_es: "Cursos de pan en la Fogaina febrero-abril 2015", 
    body_ca: "Aquí teniu els cursos per aquests primers mesos del 2015. Ja feia temps que no preparàvem una de grossa, i ara ja amb forces després de les minivacances tornem amb moltes ganes!!
           Hem preparat 3 tipus de cursos d'un matí i 1 experiència de tot el dia, per apendre i gaudir del mon panarra i de la fantàstica ubicació de La Fogaina, al bell mig de la Vall d'en Bas.
           Mes info a la pestanya de 'cursos'.", 
    body_en: "Aquí teniu els cursos per aquests primers mesos del 2015. Ja feia temps que no preparàvem una de grossa, i ara ja amb forces després de les minivacances tornem amb moltes ganes!!
           Hem preparat 3 tipus de cursos d'un matí i 1 experiència de tot el dia, per apendre i gaudir del mon panarra i de la fantàstica ubicació de La Fogaina, al bell mig de la Vall d'en Bas.
           Mes info a la pestanya de 'cursos'.", 
    body_es: "Aquí teniu els cursos per aquests primers mesos del 2015. Ja feia temps que no preparàvem una de grossa, i ara ja amb forces després de les minivacances tornem amb moltes ganes!!
           Hem preparat 3 tipus de cursos d'un matí i 1 experiència de tot el dia, per apendre i gaudir del mon panarra i de la fantàstica ubicació de La Fogaina, al bell mig de la Vall d'en Bas.
           Mes info a la pestanya de 'cursos'.", 
    publish_date: DateTime.now  
  } 
]

noticias.each do |noticia_attr|

  noticia = Refinery::News::Item.create!( 
    locale: "en", 
    title: noticia_attr[:title_en], 
    body: noticia_attr[:body_en], 
    publish_date: noticia_attr[:publish_date] )

  noticia.translations.create!( { :refinery_news_item_id => noticia.id,
                                  :locale => "ca",
                                  :title => noticia_attr[:title_ca], 
                                  :body => noticia_attr[:body_ca] } )

  noticia.translations.create!( { :refinery_news_item_id => noticia.id,
                                  :locale => "es",
                                  :title => noticia_attr[:title_es],
                                  :body => noticia_attr[:body_es] } )
end


