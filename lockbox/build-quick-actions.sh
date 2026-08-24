#!/bin/zsh
# Builds and installs the two Finder Quick Actions into ~/Library/Services.
emulate -L zsh
set -eu

HERE=${0:A:h}
LOCKBOX="$HERE/bin/lockbox"
SERVICES="$HOME/Library/Services"
mkdir -p "$SERVICES"

make_action() {
  local name=$1 verb=$2 uuid_a uuid_b uuid_c bundle
  bundle="$SERVICES/$name.workflow"
  uuid_a=$(uuidgen); uuid_b=$(uuidgen); uuid_c=$(uuidgen)

  rm -rf "$bundle"
  mkdir -p "$bundle/Contents"

  cat > "$bundle/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>NSServices</key>
	<array>
		<dict>
			<key>NSMenuItem</key>
			<dict><key>default</key><string>$name</string></dict>
			<key>NSMessage</key><string>runWorkflowAsService</string>
			<key>NSRequiredContext</key>
			<dict><key>NSApplicationIdentifier</key><string>com.apple.finder</string></dict>
			<key>NSSendFileTypes</key>
			<array><string>public.item</string></array>
		</dict>
	</array>
</dict>
</plist>
PLIST

  cat > "$bundle/Contents/document.wflow" <<WFLOW
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>AMApplicationBuild</key><string>528</string>
	<key>AMApplicationVersion</key><string>2.10</string>
	<key>AMDocumentVersion</key><string>2</string>
	<key>actions</key>
	<array>
		<dict>
			<key>action</key>
			<dict>
				<key>AMAccepts</key>
				<dict>
					<key>Container</key><string>List</string>
					<key>Optional</key><true/>
					<key>Types</key><array><string>com.apple.cocoa.string</string></array>
				</dict>
				<key>AMActionVersion</key><string>2.0.3</string>
				<key>AMApplication</key><array><string>Automator</string></array>
				<key>AMParameterProperties</key>
				<dict>
					<key>COMMAND_STRING</key><dict/>
					<key>CheckedForUserDefaultShell</key><dict/>
					<key>inputMethod</key><dict/>
					<key>shell</key><dict/>
					<key>source</key><dict/>
				</dict>
				<key>AMProvides</key>
				<dict>
					<key>Container</key><string>List</string>
					<key>Types</key><array><string>com.apple.cocoa.string</string></array>
				</dict>
				<key>ActionBundlePath</key><string>/System/Library/Automator/Run Shell Script.action</string>
				<key>ActionName</key><string>Run Shell Script</string>
				<key>ActionParameters</key>
				<dict>
					<key>COMMAND_STRING</key><string>exec "$LOCKBOX" $verb "\$@"</string>
					<key>CheckedForUserDefaultShell</key><true/>
					<key>inputMethod</key><integer>1</integer>
					<key>shell</key><string>/bin/zsh</string>
					<key>source</key><string></string>
				</dict>
				<key>BundleIdentifier</key><string>com.apple.Automator.RunShellScript</string>
				<key>CFBundleVersion</key><string>2.0.3</string>
				<key>CanShowSelectedItemsWhenRun</key><false/>
				<key>CanShowWhenRun</key><true/>
				<key>Category</key><array><string>AMCategoryUtilities</string></array>
				<key>Class Name</key><string>RunShellScriptAction</string>
				<key>InputUUID</key><string>$uuid_a</string>
				<key>Keywords</key><array><string>Shell</string><string>Script</string><string>Command</string><string>Run</string><string>Unix</string></array>
				<key>OutputUUID</key><string>$uuid_b</string>
				<key>UUID</key><string>$uuid_c</string>
				<key>UnlocalizedApplications</key><array><string>Automator</string></array>
				<key>arguments</key>
				<dict>
					<key>0</key>
					<dict>
						<key>default value</key><string></string>
						<key>name</key><string>inputMethod</string>
						<key>required</key><string>0</string>
						<key>type</key><string>0</string>
						<key>uuid</key><string>0</string>
					</dict>
					<key>1</key>
					<dict>
						<key>default value</key><false/>
						<key>name</key><string>CheckedForUserDefaultShell</string>
						<key>required</key><string>0</string>
						<key>type</key><string>0</string>
						<key>uuid</key><string>1</string>
					</dict>
					<key>2</key>
					<dict>
						<key>default value</key><string></string>
						<key>name</key><string>source</string>
						<key>required</key><string>0</string>
						<key>type</key><string>0</string>
						<key>uuid</key><string>2</string>
					</dict>
					<key>3</key>
					<dict>
						<key>default value</key><string></string>
						<key>name</key><string>COMMAND_STRING</string>
						<key>required</key><string>0</string>
						<key>type</key><string>0</string>
						<key>uuid</key><string>3</string>
					</dict>
					<key>4</key>
					<dict>
						<key>default value</key><string>/bin/sh</string>
						<key>name</key><string>shell</string>
						<key>required</key><string>0</string>
						<key>type</key><string>0</string>
						<key>uuid</key><string>4</string>
					</dict>
				</dict>
				<key>isViewVisible</key><integer>1</integer>
				<key>location</key><string>309.000000:253.000000</string>
				<key>nibPath</key><string>/System/Library/Automator/Run Shell Script.action/Contents/Resources/Base.lproj/main.nib</string>
			</dict>
			<key>isViewVisible</key><integer>1</integer>
		</dict>
	</array>
	<key>connectors</key><dict/>
	<key>workflowMetaData</key>
	<dict>
		<key>applicationBundleIDsByPath</key>
		<dict><key>/System/Library/CoreServices/Finder.app</key><string>com.apple.finder</string></dict>
		<key>applicationPaths</key>
		<array><string>/System/Library/CoreServices/Finder.app</string></array>
		<key>inputTypeIdentifier</key><string>com.apple.Automator.fileSystemObject</string>
		<key>outputTypeIdentifier</key><string>com.apple.Automator.nothing</string>
		<key>presentationMode</key><integer>15</integer>
		<key>processesInput</key><integer>0</integer>
		<key>serviceInputTypeIdentifier</key><string>com.apple.Automator.fileSystemObject</string>
		<key>serviceOutputTypeIdentifier</key><string>com.apple.Automator.nothing</string>
		<key>serviceProcessesInput</key><integer>0</integer>
		<key>systemImageName</key><string>NSTouchBarComposeTemplate</string>
		<key>useAutomaticInputType</key><integer>0</integer>
		<key>workflowTypeIdentifier</key><string>com.apple.Automator.servicesMenu</string>
	</dict>
</dict>
</plist>
WFLOW

  plutil -lint "$bundle/Contents/Info.plist" >/dev/null
  plutil -lint "$bundle/Contents/document.wflow" >/dev/null
  print "installed  $bundle"
}

make_action "Encrypt with Lockbox" lock
make_action "Decrypt with Lockbox" unlock

/System/Library/CoreServices/pbs -flush 2>/dev/null || true
/System/Library/CoreServices/pbs -update 2>/dev/null || true
print "\nQuick Actions installed. If they don't appear right away, log out and back in,"
print "or enable them under System Settings > Keyboard > Keyboard Shortcuts > Services > Files and Folders."
