# -------------------
# Methods to modify files templated with jinja2
# -------------------

# -------------------
# Renders the given jinja2 template
# 
# @param template_path Path to the template file
# @param params associative array of parameter name and the value to be set
# @param output_file_name (Optional) custom output file name.
# -------------------
def render_template(template_path, params, output_file_name=None):
    from jinja2 import Environment, FileSystemLoader
    
    if not os.path.exists(template_path):
        bb.error("The file '%s' does not exist!" % template_path)
    
    base_path, template_name = os.path.split(template_path)
    file_name, ext = os.path.splitext(template_name)
    if ext not in [".j2", ".jinja2", ".template", ".tmpl"]:
        bb.error("The template '%s' has no known extension!" % template_name)

    if output_file_name:
        file_path = os.path.join(base_path, output_file_name)
    else:
        file_path = os.path.join(base_path, file_name)
    
    file_loader = FileSystemLoader(base_path)
    env = Environment(loader=file_loader, trim_blocks=True)
    template = env.get_template(template_name)

    template.stream(params).dump(file_path)