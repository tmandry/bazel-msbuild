def _get_project_info(target, ctx):
  return struct(
      workspace_root = ctx.label.workspace_root,
      package        = ctx.label.package,
      files = struct(**{name: _get_file_group(ctx.rule.attr, name) for name in ['srcs', 'hdrs']}),
      deps  = [str(dep.label) for dep in getattr(ctx.rule.attr, 'deps', [])],
      target = struct(label=str(target.label), files=[f.path for f in target.files]),
  )

def _get_file_group(rule_attrs, attr_name):
  file_targets = getattr(rule_attrs, attr_name, None)
  if not file_targets: return []
  return [file.path for t in file_targets for file in t.files]

def _msbuild_aspect_impl(target, ctx):
  info_file = ctx.actions.declare_file(target.label.name + '.msbuild')
  content = _get_project_info(target, ctx).to_json()
  ctx.actions.write(info_file, content, is_executable=False)

  outputs = depset([info_file])
  for dep in getattr(ctx.rule.attr, 'deps', []):
    outputs += dep[OutputGroupInfo].msbuild_outputs
  return [OutputGroupInfo(msbuild_outputs=outputs)]

msbuild_aspect = aspect(
    attr_aspects = ["deps"],
    implementation = _msbuild_aspect_impl,
)
