class HomeController < ApplicationController
	before_filter :require_valid_user
	def show
	end

	def database
		# Conectamos la BD
		#my = Mysql::new("127.0.0.1", "root", "kaosbite", "clerk_development")
		my = Mysql::new("coddea.com", "trancar1_clinica", "clinica2012+-", "trancar1_calemana_deporteesmipasion2013")
		# Contamos los registros en la BD
		count = my.query("SELECT COUNT(*) FROM participantes USE INDEX(PRIMARY);")
		@cantidad = 0
		count.each do |contador|
			@cantidad = contador[0].to_i
		end
		# Dividimos la cantidad de registro por la cantidad por pagina para obtener el numero de paginas.
		@cantidad = @cantidad / 20
		# Determinamos si viene el parametro page
		page = 0
		if !params[:page].blank?
			page = params[:page].to_i * 20
		end
		@res = my.query("select * from participantes limit "+page.to_s+",20")
	end

	def download
		p = Axlsx::Package.new
		# Conectamos la BD
		#my = Mysql::new("127.0.0.1", "root", "kaosbite", "clerk_development")
		my = Mysql::new("coddea.com", "trancar1_clinica", "clinica2012+-", "trancar1_calemana_deporteesmipasion2013")
		@res = my.query("select * from participantes")
		p.workbook.add_worksheet(:name => "Reporte") do |sheet|
			sheet.add_row ["ID", "Nombre", "Apellido", "Nombre Completo", "Deporte", "Email", "Username", "Origen", "Cuando"]
			@res.each do |elemento|
				sheet.add_row [elemento[0], elemento[3], elemento[4], elemento[5], elemento[6], elemento[7], elemento[8], elemento[10], elemento[11]]
			end
		end
		p.use_shared_strings = true
		p.serialize('public/reporte.xlsx')
		redirect_to('/reporte.xlsx')
	end
end