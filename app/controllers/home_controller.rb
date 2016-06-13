class HomeController < ApplicationController
	before_filter :require_valid_user
	def show
	end

	def database
		# Conectamos la BD
		my = Mysql::new("104.236.148.150", "calemana", "calemana2016+-", "fb_calemana_comotecuidas_2016")
		# Contamos los registros en la BD
		my.query("SET NAMES UTF8")
		count = my.query("SELECT COUNT(*) FROM participant USE INDEX(PRIMARY);")
		@cantidad = 0
		@contador = 0
		count.each do |contador|
			@cantidad = contador[0].to_i
			@contador = @cantidad
		end
		# Dividimos la cantidad de registro por la cantidad por pagina para obtener el numero de paginas.
		@cantidad = @cantidad / 20
		# Determinamos si viene el parametro page
		page = 0
		if !params[:page].blank?
			if params[:page].to_i > 0
				page = (params[:page].to_i-1) * 20
			else
				page = 0
			end
		end
		@res = my.query("select * from participant order by created_at desc limit "+page.to_s+",20")
	end

	def download
		p = Axlsx::Package.new
		# Conectamos la BD
		my = Mysql::new("104.236.148.150", "calemana", "calemana2016+-", "fb_calemana_comotecuidas_2016")
		my.query("SET NAMES UTF8")
		@res = my.query("select * from participant")
		# Comenzamos a aplicar estilos para axlsx
		p.workbook.styles do |s|
			wrap_text = s.add_style :fg_color=> "FFFFFF",
				:b => true,
				:bg_color => "004586",
				:sz => 12,
				:border => { :style => :thin, :color => "00" },
				:alignment => { :horizontal => :center,
					:vertical => :center ,
					:wrap_text => true }
			p.workbook.add_worksheet(:name => "Reporte") do |sheet|
				sheet.add_row ["userID", "Nombre", "Apellido", "Nombre Completo", "Email", "txt", "template", "Origin", "post_id", "Fecha"], :style => wrap_text
				@res.each do |elemento|
					sheet.add_row [elemento[1], elemento[3], elemento[4], elemento[5], elemento[6], elemento[7], elemento[8], elemento[9], elemento[10], elemento[11]]
				end
			end
		end
		p.use_shared_strings = true
		p.serialize('public/reporte.xlsx')
		redirect_to('/reporte.xlsx')
	end
end
